#!/usr/bin/env node
/**
 * generate-tts-cache.mjs
 *
 * Pre-generate TTS audio for story scenes and upload to Supabase Storage.
 *
 * Usage:
 *   # Generate all chapters (Japanese)
 *   node scripts/generate-tts-cache.mjs
 *
 *   # Generate specific chapter
 *   node scripts/generate-tts-cache.mjs --chapter 1
 *
 *   # Force re-generate (overwrite existing)
 *   node scripts/generate-tts-cache.mjs --chapter 1 --force
 *
 * Environment variables (required):
 *   SUPABASE_URL            - Supabase project URL
 *   SUPABASE_SERVICE_ROLE_KEY - Supabase service role key
 *   GEMINI_API_KEY          - Primary Gemini API key
 *   GEMINI_API_KEY2         - Secondary Gemini API key (for rotation)
 */

import { createClient } from '@supabase/supabase-js';

// ─── Configuration ───────────────────────────────────────────────────────────

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const GEMINI_KEYS = [
  process.env.GEMINI_API_KEY,
  process.env.GEMINI_API_KEY2,
].filter(Boolean);

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('❌ Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY');
  console.error('   Set them as environment variables before running.');
  process.exit(1);
}
if (GEMINI_KEYS.length === 0) {
  console.error('❌ Missing GEMINI_API_KEY (and optionally GEMINI_API_KEY2)');
  process.exit(1);
}

const TTS_MODEL = 'gemini-2.5-flash-preview-tts';
const TTS_ENDPOINT = `https://generativelanguage.googleapis.com/v1beta/models/${TTS_MODEL}:generateContent`;
const STORAGE_BUCKET = 'tts-cache';
const LANG = 'ja';
const DELAY_MS = 4000; // Delay between API calls to avoid rate limiting
const SAMPLE_RATE = 24000;
const BITS_PER_SAMPLE = 16;
const NUM_CHANNELS = 1;

// ─── Character → Voice mapping ───────────────────────────────────────────────

const CHARACTER_VOICE_MAP = {
  '11111111-1111-1111-1111-111111111111': 'Puck',      // ビットくん
  '22222222-2222-2222-2222-222222222222': 'Kore',       // バイトさん
  '33333333-3333-3333-3333-333333333333': 'Aoede',      // ファイラ
  '44444444-4444-4444-4444-444444444444': 'Enceladus',  // ストラクト博士
  '55555555-5555-5555-5555-555555555555': 'Leda',       // ループちゃん
  '66666666-6666-6666-6666-666666666666': 'Sadachbia',  // HTMLくん
  '77777777-7777-7777-7777-777777777777': 'Umbriel',    // CSSちゃん
  '88888888-8888-8888-8888-888888888888': 'Fenrir',     // ルーター船長
  '99999999-9999-9999-9999-999999999999': 'Gacrux',     // JSマスター
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa': 'Schedar',    // リアクト先生
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb': 'Callirrhoe', // UIデザイナー・ミア
  'cccccccc-cccc-cccc-cccc-cccccccccccc': 'Algieba',    // テイル職人
  'dddddddd-dddd-dddd-dddd-dddddddddddd': 'Rasalgethi', // ターミナルじいさん
  'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee': 'Achird',    // パッケージ配達員
  'ffffffff-ffff-ffff-ffff-ffffffffffff': 'Iapetus',    // ギット管理人
  '00000000-0000-0000-0001-000000000001': 'Charon',     // サーバー守護者
  '00000000-0000-0000-0002-000000000002': 'Vindemiatrix', // API大使
  '00000000-0000-0000-0003-000000000003': 'Despina',       // コードバタフライたち
};
const DEFAULT_VOICE = 'Puck'; // ナレーション・デフォルト

// ─── Parse CLI arguments ─────────────────────────────────────────────────────

const args = process.argv.slice(2);
let targetChapter = null;
let forceOverwrite = false;

for (let i = 0; i < args.length; i++) {
  if (args[i] === '--chapter' && args[i + 1]) {
    targetChapter = parseInt(args[i + 1], 10);
    i++;
  }
  if (args[i] === '--force') {
    forceOverwrite = true;
  }
}

// ─── Supabase client ─────────────────────────────────────────────────────────

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

// ─── Gemini API key rotation ─────────────────────────────────────────────────

let keyIndex = 0;
function getNextGeminiKey() {
  const key = GEMINI_KEYS[keyIndex % GEMINI_KEYS.length];
  keyIndex++;
  return key;
}

// ─── PCM → WAV conversion ────────────────────────────────────────────────────

function pcmBase64ToWavBuffer(pcmBase64) {
  const pcmBytes = Buffer.from(pcmBase64, 'base64');
  const dataSize = pcmBytes.length;
  const blockAlign = NUM_CHANNELS * (BITS_PER_SAMPLE / 8);
  const byteRate = SAMPLE_RATE * blockAlign;
  const headerSize = 44;

  const buffer = Buffer.alloc(headerSize + dataSize);

  // RIFF header
  buffer.write('RIFF', 0);
  buffer.writeUInt32LE(36 + dataSize, 4);
  buffer.write('WAVE', 8);

  // fmt chunk
  buffer.write('fmt ', 12);
  buffer.writeUInt32LE(16, 16);        // chunk size
  buffer.writeUInt16LE(1, 20);         // PCM format
  buffer.writeUInt16LE(NUM_CHANNELS, 22);
  buffer.writeUInt32LE(SAMPLE_RATE, 24);
  buffer.writeUInt32LE(byteRate, 28);
  buffer.writeUInt16LE(blockAlign, 32);
  buffer.writeUInt16LE(BITS_PER_SAMPLE, 34);

  // data chunk
  buffer.write('data', 36);
  buffer.writeUInt32LE(dataSize, 40);
  pcmBytes.copy(buffer, headerSize);

  return buffer;
}

// ─── Gemini TTS API call ─────────────────────────────────────────────────────

async function callGeminiTts(text, voiceName) {
  const apiKey = getNextGeminiKey();
  const ttsPrompt = `Read the following text aloud in a natural, expressive voice:\n\n${text}`;

  const requestBody = {
    contents: [{ parts: [{ text: ttsPrompt }] }],
    generationConfig: {
      responseModalities: ['AUDIO'],
      speechConfig: {
        voiceConfig: {
          prebuiltVoiceConfig: { voiceName },
        },
      },
    },
  };

  const res = await fetch(`${TTS_ENDPOINT}?key=${apiKey}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(requestBody),
  });

  if (!res.ok) {
    const errText = await res.text().catch(() => 'Unknown');
    throw new Error(`Gemini API ${res.status}: ${errText}`);
  }

  const json = await res.json();
  const audioData = json?.candidates?.[0]?.content?.parts?.[0]?.inlineData?.data;

  if (!audioData) {
    throw new Error('No audio data in Gemini response');
  }

  return audioData; // base64 PCM
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

function sceneToText(scene) {
  const parts = [scene.title, scene.content].filter(Boolean);
  const raw = parts.join('\n\n');
  // Strip image markers like {{image:...}} and speaker tags like {{speaker:...}}
  return raw
    .replace(/\{\{image:[^}]+\}\}/g, '')
    .replace(/\{\{speaker:[^}]*\}\}\n?/g, '')
    .trim();
}

function getVoiceForScene(scene) {
  const charIds = scene.character_ids || [];
  if (charIds.length === 0) return DEFAULT_VOICE;
  // Use the first character's voice
  return CHARACTER_VOICE_MAP[charIds[0]] || DEFAULT_VOICE;
}

function storagePath(chapterId, sceneNumber) {
  return `${LANG}/ch${chapterId}/scene${sceneNumber}.wav`;
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// ─── Check if file exists in Storage ─────────────────────────────────────────

async function fileExistsInStorage(path) {
  const { data } = await supabase.storage.from(STORAGE_BUCKET).list(
    path.substring(0, path.lastIndexOf('/')),
    { search: path.substring(path.lastIndexOf('/') + 1) }
  );
  return data && data.length > 0;
}

// ─── Ensure bucket exists ────────────────────────────────────────────────────

async function ensureBucket() {
  const { data: buckets } = await supabase.storage.listBuckets();
  const exists = buckets?.some((b) => b.name === STORAGE_BUCKET);

  if (!exists) {
    console.log(`📦 Creating storage bucket "${STORAGE_BUCKET}"...`);
    const { error } = await supabase.storage.createBucket(STORAGE_BUCKET, {
      public: true,
      fileSizeLimit: 10 * 1024 * 1024, // 10MB
    });
    if (error) throw new Error(`Failed to create bucket: ${error.message}`);
    console.log(`   ✓ Bucket created`);
  } else {
    console.log(`📦 Bucket "${STORAGE_BUCKET}" exists`);
  }
}

// ─── Main ────────────────────────────────────────────────────────────────────

async function main() {
  console.log('🎙️  TTS Audio Cache Generator');
  console.log(`   Supabase: ${SUPABASE_URL}`);
  console.log(`   Gemini keys: ${GEMINI_KEYS.length}`);
  console.log(`   Language: ${LANG}`);
  console.log(`   Target: ${targetChapter ? `Chapter ${targetChapter}` : 'All chapters'}`);
  console.log(`   Force overwrite: ${forceOverwrite}`);
  console.log('');

  // Ensure bucket exists
  await ensureBucket();

  // Fetch scenes
  let query = supabase
    .from('story_scenes')
    .select('*')
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

  let generated = 0;
  let skipped = 0;
  let failed = 0;

  for (const scene of scenes) {
    const path = storagePath(scene.chapter_id, scene.scene_number);
    const label = `Ch${scene.chapter_id} Scene${scene.scene_number}`;

    // Check if already cached
    if (!forceOverwrite) {
      const exists = await fileExistsInStorage(path);
      if (exists) {
        console.log(`⏭️  ${label} — already cached, skipping`);
        skipped++;
        continue;
      }
    }

    const text = sceneToText(scene);
    if (!text || text.length < 5) {
      console.log(`⏭️  ${label} — too short or empty, skipping`);
      skipped++;
      continue;
    }

    const voice = getVoiceForScene(scene);

    try {
      process.stdout.write(`🔊 ${label} (${voice}, ${text.length} chars)... `);

      const pcmBase64 = await callGeminiTts(text, voice);
      const wavBuffer = pcmBase64ToWavBuffer(pcmBase64);

      const { error: uploadError } = await supabase.storage
        .from(STORAGE_BUCKET)
        .upload(path, wavBuffer, {
          contentType: 'audio/wav',
          upsert: true,
        });

      if (uploadError) {
        throw new Error(`Upload failed: ${uploadError.message}`);
      }

      const sizeMb = (wavBuffer.length / 1024 / 1024).toFixed(2);
      console.log(`✓ ${sizeMb}MB`);
      generated++;
    } catch (err) {
      console.log(`✗ ${err.message}`);
      failed++;

      // If rate limited, wait longer
      if (err.message.includes('429') || err.message.includes('RESOURCE_EXHAUSTED')) {
        console.log('   ⏳ Rate limited — waiting 60s...');
        await sleep(60000);
      }
    }

    // Delay between requests to avoid rate limits
    await sleep(DELAY_MS);
  }

  console.log('\n────────────────────────────');
  console.log(`✅ Generated: ${generated}`);
  console.log(`⏭️  Skipped:   ${skipped}`);
  console.log(`❌ Failed:     ${failed}`);
  console.log(`📁 Total:      ${scenes.length} scenes`);

  if (generated > 0) {
    const samplePath = storagePath(scenes[0].chapter_id, scenes[0].scene_number);
    const { data } = supabase.storage.from(STORAGE_BUCKET).getPublicUrl(samplePath);
    console.log(`\n🔗 Sample URL: ${data.publicUrl}`);
  }
}

main().catch((err) => {
  console.error('\n💥 Fatal error:', err);
  process.exit(1);
});
