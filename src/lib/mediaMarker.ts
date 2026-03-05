/**
 * Utilities for parsing {{image:...}} and {{video:...}} media markers
 * embedded in story scene content.
 *
 * Markers may include an optional size hint:
 *   {{image:url|size=md}}  or  {{image:url}}  (defaults to 'md')
 */

export const MEDIA_MARKER_RE = /\{\{(image|video):([^}]+)\}\}/;

export const VALID_SIZES = ['sm', 'md', 'lg', 'full'] as const;
export type MediaSize = (typeof VALID_SIZES)[number];

export type MediaSegment = { type: 'image' | 'video'; src: string; size?: MediaSize };

/**
 * Parse the raw value inside a marker (everything between `type:` and `}}`).
 * Splits on the *last* `|size=` to avoid clashing with URLs that contain `|`.
 */
function parseSrcAndSize(raw: string): { src: string; size?: MediaSize } {
  const sizeMatch = raw.match(/\|size=(\w+)$/);
  if (!sizeMatch) return { src: raw };

  const sizeStr = sizeMatch[1];
  const src = raw.slice(0, sizeMatch.index);
  if ((VALID_SIZES as readonly string[]).includes(sizeStr)) {
    return { src, size: sizeStr as MediaSize };
  }
  // Invalid size value — ignore the hint, keep the full raw as src
  return { src: raw };
}

/**
 * Split a content string into an array of plain-text strings and
 * media segments identified by `{{image:url}}` or `{{video:url}}` markers.
 *
 * - Text-only content returns a single-element string array.
 * - Incomplete markers (e.g. `{{image:` without closing `}}`) are treated as
 *   plain text.
 * - Empty input returns an empty array.
 * - Markers may include `|size=sm|md|lg|full`; unrecognised sizes are ignored.
 */
/**
 * Strip {{speaker:...}} tags from content. These are metadata-only markers
 * used for TTS voice assignment and should not be rendered.
 */
function stripSpeakerTags(text: string): string {
  return text.replace(/\{\{speaker:[^}]*\}\}\n?/g, '');
}

export function splitContentByMedia(content: string): (string | MediaSegment)[] {
  if (!content) return [];

  const segments: (string | MediaSegment)[] = [];
  let remaining = stripSpeakerTags(content);

  while (remaining) {
    const match = MEDIA_MARKER_RE.exec(remaining);
    if (!match) {
      segments.push(remaining);
      break;
    }
    if (match.index > 0) {
      segments.push(remaining.slice(0, match.index));
    }
    const { src, size } = parseSrcAndSize(match[2]);
    const segment: MediaSegment = { type: match[1] as 'image' | 'video', src };
    if (size) segment.size = size;
    segments.push(segment);
    remaining = remaining.slice(match.index + match[0].length);
  }

  return segments;
}
