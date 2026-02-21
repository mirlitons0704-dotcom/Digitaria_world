/**
 * Utilities for parsing {{image:...}} and {{video:...}} media markers
 * embedded in story scene content.
 */

export const MEDIA_MARKER_RE = /\{\{(image|video):([^}]+)\}\}/;

export type MediaSegment = { type: 'image' | 'video'; src: string };

/**
 * Split a content string into an array of plain-text strings and
 * media segments identified by `{{image:url}}` or `{{video:url}}` markers.
 *
 * - Text-only content returns a single-element string array.
 * - Incomplete markers (e.g. `{{image:` without closing `}}`) are treated as
 *   plain text.
 * - Empty input returns an empty array.
 */
export function splitContentByMedia(content: string): (string | MediaSegment)[] {
  if (!content) return [];

  const segments: (string | MediaSegment)[] = [];
  let remaining = content;

  while (remaining) {
    const match = MEDIA_MARKER_RE.exec(remaining);
    if (!match) {
      segments.push(remaining);
      break;
    }
    if (match.index > 0) {
      segments.push(remaining.slice(0, match.index));
    }
    segments.push({ type: match[1] as 'image' | 'video', src: match[2] });
    remaining = remaining.slice(match.index + match[0].length);
  }

  return segments;
}
