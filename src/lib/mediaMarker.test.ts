import { describe, it, expect } from 'vitest';
import { splitContentByMedia } from './mediaMarker';

describe('splitContentByMedia', () => {
  it('returns empty array for empty string', () => {
    expect(splitContentByMedia('')).toEqual([]);
  });

  it('returns single text segment when no markers present', () => {
    const text = 'ビットくんが言った。「やあ！」';
    expect(splitContentByMedia(text)).toEqual([text]);
  });

  it('parses a single image marker', () => {
    const input = 'before\n\n{{image:https://example.com/img.png}}\n\nafter';
    const result = splitContentByMedia(input);

    expect(result).toEqual([
      'before\n\n',
      { type: 'image', src: 'https://example.com/img.png' },
      '\n\nafter',
    ]);
  });

  it('parses a video marker', () => {
    const input = '{{video:https://example.com/vid.mp4}}';
    const result = splitContentByMedia(input);

    expect(result).toEqual([{ type: 'video', src: 'https://example.com/vid.mp4' }]);
  });

  it('parses multiple markers', () => {
    const input = 'text1{{image:a.png}}middle{{image:b.png}}end';
    const result = splitContentByMedia(input);

    expect(result).toEqual([
      'text1',
      { type: 'image', src: 'a.png' },
      'middle',
      { type: 'image', src: 'b.png' },
      'end',
    ]);
  });

  it('handles consecutive markers without text between them', () => {
    const input = '{{image:a.png}}{{video:b.mp4}}';
    const result = splitContentByMedia(input);

    expect(result).toEqual([
      { type: 'image', src: 'a.png' },
      { type: 'video', src: 'b.mp4' },
    ]);
  });

  it('treats incomplete marker as plain text', () => {
    const input = 'some text {{image: not closed';
    expect(splitContentByMedia(input)).toEqual([input]);
  });

  it('handles Supabase storage URLs used in production', () => {
    const url = 'https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png';
    const input = `ビットは8人集まるとバイトになる\n\n{{image:${url}}}\n\n続きのテキスト`;
    const result = splitContentByMedia(input);

    expect(result).toHaveLength(3);
    expect(result[1]).toEqual({ type: 'image', src: url });
  });

  it('handles marker at the very start of content', () => {
    const input = '{{image:start.png}}trailing text';
    const result = splitContentByMedia(input);

    expect(result).toEqual([{ type: 'image', src: 'start.png' }, 'trailing text']);
  });

  it('handles marker at the very end of content', () => {
    const input = 'leading text{{image:end.png}}';
    const result = splitContentByMedia(input);

    expect(result).toEqual(['leading text', { type: 'image', src: 'end.png' }]);
  });
});
