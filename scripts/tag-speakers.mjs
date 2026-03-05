#!/usr/bin/env node
/**
 * tag-speakers.mjs
 *
 * Automatically insert {{speaker:VoiceName}} tags before dialogue lines (「」)
 * in story_scenes.content. Uses heuristics to detect speakers from context.
 *
 * Usage:
 *   # Dry-run: show changes without updating DB
 *   node scripts/tag-speakers.mjs --dry-run
 *
 *   # Dry-run for specific chapter
 *   node scripts/tag-speakers.mjs --dry-run --chapter 1
 *
 *   # Apply changes to DB
 *   node scripts/tag-speakers.mjs --apply
 *
 *   # Apply for specific chapter
 *   node scripts/tag-speakers.mjs --apply --chapter 1
 *
 * Environment variables (required):
 *   SUPABASE_URL
 *   SUPABASE_SERVICE_ROLE_KEY
 */

import { createClient } from '@supabase/supabase-js';

// ─── Configuration ───────────────────────────────────────────────────────────

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('❌ Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

// ─── Character name → VoiceName mapping ──────────────────────────────────────
// Keys are substrings that appear in story text near dialogue.

const CHARACTER_VOICE_MAP = {
  '11111111-1111-1111-1111-111111111111': 'Puck',
  '22222222-2222-2222-2222-222222222222': 'Kore',
  '33333333-3333-3333-3333-333333333333': 'Aoede',
  '44444444-4444-4444-4444-444444444444': 'Enceladus',
  '55555555-5555-5555-5555-555555555555': 'Leda',
  '66666666-6666-6666-6666-666666666666': 'Sadachbia',
  '77777777-7777-7777-7777-777777777777': 'Umbriel',
  '88888888-8888-8888-8888-888888888888': 'Fenrir',
  '99999999-9999-9999-9999-999999999999': 'Gacrux',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa': 'Schedar',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb': 'Callirrhoe',
  'cccccccc-cccc-cccc-cccc-cccccccccccc': 'Algieba',
  'dddddddd-dddd-dddd-dddd-dddddddddddd': 'Rasalgethi',
  'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee': 'Achird',
  'ffffffff-ffff-ffff-ffff-ffffffffffff': 'Iapetus',
  '00000000-0000-0000-0001-000000000001': 'Charon',
  '00000000-0000-0000-0002-000000000002': 'Vindemiatrix',
  '00000000-0000-0000-0003-000000000003': 'Despina',
};

// Story text names → UUID mapping (supports partial matches)
const NAME_TO_UUID = [
  // Specific names first (longer matches take priority)
  { patterns: ['ビットくん', 'ビット君'], uuid: '11111111-1111-1111-1111-111111111111' },
  { patterns: ['バイトさん', 'バイト'], uuid: '22222222-2222-2222-2222-222222222222' },
  { patterns: ['ファイラ'], uuid: '33333333-3333-3333-3333-333333333333' },
  { patterns: ['ストラクト博士', '博士が', '博士は'], uuid: '44444444-4444-4444-4444-444444444444' },
  { patterns: ['ループちゃん'], uuid: '55555555-5555-5555-5555-555555555555' },
  { patterns: ['HTMLくん', 'HTML くん', 'HTMLが', 'HTML が'], uuid: '66666666-6666-6666-6666-666666666666' },
  { patterns: ['CSSちゃん', 'CSS ちゃん', 'CSSが', 'CSS が'], uuid: '77777777-7777-7777-7777-777777777777' },
  { patterns: ['ルーター船長', '船長が', '船長は'], uuid: '88888888-8888-8888-8888-888888888888' },
  { patterns: ['JSマスター', 'JS マスター', '師範が', '師範は', '師匠'], uuid: '99999999-9999-9999-9999-999999999999' },
  { patterns: ['リアクト先生'], uuid: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' },
  { patterns: ['ミアさん', 'ミアが', 'UIデザイナーのミア'], uuid: 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb' },
  { patterns: ['テイル職人'], uuid: 'cccccccc-cccc-cccc-cccc-cccccccccccc' },
  { patterns: ['ターミナルじいさん', 'じいさんが', 'じいさんは'], uuid: 'dddddddd-dddd-dddd-dddd-dddddddddddd' },
  { patterns: ['パッケージ配達員'], uuid: 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee' },
  { patterns: ['ギット管理人'], uuid: 'ffffffff-ffff-ffff-ffff-ffffffffffff' },
  { patterns: ['サーバー守護者'], uuid: '00000000-0000-0000-0001-000000000001' },
  { patterns: ['API大使', 'API 大使'], uuid: '00000000-0000-0000-0002-000000000002' },
  // Generic "ビット" last (could be ambiguous)
  { patterns: ['ビットくんが', 'ビットが'], uuid: '11111111-1111-1111-1111-111111111111' },
];

// Chapter guide characters (fallback when scene has single character)
const CHAPTER_GUIDE = {
  1: '11111111-1111-1111-1111-111111111111',  // ビットくん
  2: '33333333-3333-3333-3333-333333333333',  // ファイラ
  3: '44444444-4444-4444-4444-444444444444',  // ストラクト博士
  4: '55555555-5555-5555-5555-555555555555',  // ループちゃん
  5: '66666666-6666-6666-6666-666666666666',  // HTMLくん (+ CSSちゃん)
  6: '88888888-8888-8888-8888-888888888888',  // ルーター船長
  7: '99999999-9999-9999-9999-999999999999',  // JSマスター
  8: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',  // リアクト先生
  9: 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',  // UIデザイナー・ミア
  10: 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', // UIデザイナー・ミア
  11: 'cccccccc-cccc-cccc-cccc-cccccccccccc', // テイル職人
  12: 'dddddddd-dddd-dddd-dddd-dddddddddddd', // ターミナルじいさん
  13: 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', // パッケージ配達員
  14: 'ffffffff-ffff-ffff-ffff-ffffffffffff', // ギット管理人
  15: '00000000-0000-0000-0001-000000000001', // サーバー守護者
  16: '00000000-0000-0000-0002-000000000002', // API大使
  17: '11111111-1111-1111-1111-111111111111', // ビットくん
};

// ─── Parse CLI arguments ─────────────────────────────────────────────────────

const args = process.argv.slice(2);
let targetChapter = null;
let mode = null; // 'dry-run' or 'apply'

for (let i = 0; i < args.length; i++) {
  if (args[i] === '--chapter' && args[i + 1]) {
    targetChapter = parseInt(args[i + 1], 10);
    i++;
  }
  if (args[i] === '--dry-run') mode = 'dry-run';
  if (args[i] === '--apply') mode = 'apply';
}

if (!mode) {
  console.error('Usage: node scripts/tag-speakers.mjs [--dry-run|--apply] [--chapter N]');
  console.error('  --dry-run  Show changes without writing to DB');
  console.error('  --apply    Write changes to DB');
  process.exit(1);
}

// ─── Speaker detection logic ─────────────────────────────────────────────────

/**
 * Find character UUID mentioned in a text snippet.
 * Returns UUID or null.
 */
function findCharacterInText(text) {
  if (!text) return null;
  for (const entry of NAME_TO_UUID) {
    for (const pattern of entry.patterns) {
      if (text.includes(pattern)) {
        return entry.uuid;
      }
    }
  }
  return null;
}

/**
 * Check if a paragraph contains dialogue (「」).
 */
function hasDialogue(paragraph) {
  return /「[^」]*」/.test(paragraph);
}

/**
 * Check if a paragraph is ONLY dialogue (starts with 「).
 */
function isDialogueOnly(paragraph) {
  return /^「/.test(paragraph.trim());
}

/**
 * Check if content already has speaker tags.
 */
function hasExistingSpeakerTags(content) {
  return /\{\{speaker:[^}]+\}\}/.test(content);
}

/**
 * Tag dialogue paragraphs in a scene's content with {{speaker:VoiceName}}.
 *
 * @param {string} content - The scene content
 * @param {string[]} characterIds - Character UUIDs in this scene
 * @param {number} chapterId - Chapter number
 * @returns {{ taggedContent: string, stats: { tagged: number, unknown: number } }}
 */
function tagContent(content, characterIds, chapterId) {
  // Skip if already tagged
  if (hasExistingSpeakerTags(content)) {
    return { taggedContent: content, stats: { tagged: 0, unknown: 0, skipped: true } };
  }

  const paragraphs = content.split('\n\n');
  const result = [];
  let tagged = 0;
  let unknown = 0;

  // Track the last identified speaker for consecutive dialogue
  let lastSpeaker = null;

  for (let i = 0; i < paragraphs.length; i++) {
    const para = paragraphs[i];

    // Skip image/media markers
    if (/^\{\{(image|video):/.test(para.trim())) {
      result.push(para);
      continue;
    }

    // If paragraph contains dialogue
    if (hasDialogue(para)) {
      let speakerUuid = null;

      // Strategy 1: Check the previous paragraph for character name mention
      if (i > 0) {
        speakerUuid = findCharacterInText(paragraphs[i - 1]);
      }

      // Strategy 2: Check same paragraph for mixed narration+dialogue
      // e.g., "ビットくんが嬉しそうに言った。\n「...」"
      if (!speakerUuid && !isDialogueOnly(para)) {
        // Text before the first 「 might contain the speaker's name
        const beforeDialogue = para.split('「')[0];
        speakerUuid = findCharacterInText(beforeDialogue);
      }

      // Strategy 3: Check the next paragraph for speaker identification
      // e.g., 「...」\nビットくんが微笑んだ。
      if (!speakerUuid && i + 1 < paragraphs.length) {
        speakerUuid = findCharacterInText(paragraphs[i + 1]);
      }

      // Strategy 4: If scene has only one character, use that
      if (!speakerUuid && characterIds.length === 1) {
        speakerUuid = characterIds[0];
      }

      // Strategy 5: If consecutive dialogue and previous speaker is known,
      // check if this might be a different speaker (alternating dialogue)
      // For now, keep lastSpeaker for same-speaker sequences
      if (!speakerUuid && lastSpeaker) {
        // If scene has exactly 2 characters and this is dialogue-only,
        // it might be alternating speakers
        if (characterIds.length === 2 && isDialogueOnly(para)) {
          // Alternate: pick the other character
          const otherChar = characterIds.find(id => id !== lastSpeaker);
          if (otherChar) {
            speakerUuid = otherChar;
          }
        } else {
          // Default: keep same speaker for consecutive dialogue
          speakerUuid = lastSpeaker;
        }
      }

      // Strategy 6: Fall back to chapter guide
      if (!speakerUuid) {
        const guideUuid = CHAPTER_GUIDE[chapterId];
        if (guideUuid && characterIds.includes(guideUuid)) {
          speakerUuid = guideUuid;
        }
      }

      // Resolve voice name
      const voiceName = speakerUuid
        ? (CHARACTER_VOICE_MAP[speakerUuid] || '???')
        : '???';

      result.push(`{{speaker:${voiceName}}}\n${para}`);
      tagged++;
      if (voiceName === '???') unknown++;
      lastSpeaker = speakerUuid;
    } else {
      // Plain narration — no tag (defaults to Kore)
      result.push(para);
      lastSpeaker = null; // Reset speaker tracking after narration
    }
  }

  return {
    taggedContent: result.join('\n\n'),
    stats: { tagged, unknown, skipped: false },
  };
}

// ─── Main ────────────────────────────────────────────────────────────────────

async function main() {
  console.log('🏷️  Speaker Tag Generator');
  console.log(`   Mode: ${mode}`);
  console.log(`   Target: ${targetChapter ? `Chapter ${targetChapter}` : 'All chapters'}`);
  console.log('');

  // Fetch scenes
  let query = supabase
    .from('story_scenes')
    .select('id, chapter_id, scene_number, title, content, character_ids')
    .order('chapter_id', { ascending: true })
    .order('scene_number', { ascending: true });

  if (targetChapter) {
    query = query.eq('chapter_id', targetChapter);
  }

  const { data: scenes, error } = await query;
  if (error) {
    console.error('❌ Failed to fetch scenes:', error.message);
    process.exit(1);
  }

  console.log(`📄 Found ${scenes.length} scenes\n`);

  let totalTagged = 0;
  let totalUnknown = 0;
  let totalSkipped = 0;
  let totalUpdated = 0;

  for (const scene of scenes) {
    const label = `Ch${scene.chapter_id} Scene${scene.scene_number} "${scene.title || ''}"`;

    const { taggedContent, stats } = tagContent(
      scene.content,
      scene.character_ids || [],
      scene.chapter_id
    );

    if (stats.skipped) {
      console.log(`⏭️  ${label} — already tagged, skipping`);
      totalSkipped++;
      continue;
    }

    if (stats.tagged === 0) {
      console.log(`⏭️  ${label} — no dialogue found`);
      continue;
    }

    const unknownLabel = stats.unknown > 0 ? ` (⚠️ ${stats.unknown} unknown)` : '';
    console.log(`🏷️  ${label} — ${stats.tagged} dialogues tagged${unknownLabel}`);

    totalTagged += stats.tagged;
    totalUnknown += stats.unknown;

    if (mode === 'dry-run') {
      // Show diff preview
      const lines = taggedContent.split('\n');
      for (const line of lines) {
        if (line.startsWith('{{speaker:')) {
          const isUnknown = line.includes('???');
          console.log(`   ${isUnknown ? '❓' : '✅'} ${line}`);
        }
      }
    } else if (mode === 'apply') {
      const { error: updateError } = await supabase
        .from('story_scenes')
        .update({ content: taggedContent })
        .eq('id', scene.id);

      if (updateError) {
        console.error(`   ❌ Failed to update: ${updateError.message}`);
      } else {
        console.log(`   ✓ Updated in DB`);
        totalUpdated++;
      }
    }
  }

  console.log('\n────────────────────────────');
  console.log(`🏷️  Dialogues tagged:  ${totalTagged}`);
  console.log(`❓ Unknown speakers:   ${totalUnknown}`);
  console.log(`⏭️  Scenes skipped:    ${totalSkipped}`);
  if (mode === 'apply') {
    console.log(`✅ Scenes updated:     ${totalUpdated}`);
  }
  console.log(`📄 Total scenes:       ${scenes.length}`);

  if (totalUnknown > 0) {
    console.log(`\n⚠️  ${totalUnknown} dialogue(s) marked as {{speaker:???}} — please review manually in the admin editor.`);
  }
}

main().catch((err) => {
  console.error('\n💥 Fatal error:', err);
  process.exit(1);
});
