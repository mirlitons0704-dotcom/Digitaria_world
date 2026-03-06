import { supabase } from './supabase';

const SAMPLE_RATE = 24000;
const BITS_PER_SAMPLE = 16;
const NUM_CHANNELS = 1;

function pcmToWavBlob(pcmBase64: string): Blob {
  const raw = atob(pcmBase64);
  const pcmBytes = new Uint8Array(raw.length);
  for (let i = 0; i < raw.length; i++) {
    pcmBytes[i] = raw.charCodeAt(i);
  }

  const dataSize = pcmBytes.length;
  const blockAlign = NUM_CHANNELS * (BITS_PER_SAMPLE / 8);
  const byteRate = SAMPLE_RATE * blockAlign;
  const fileSize = 36 + dataSize;

  const buffer = new ArrayBuffer(44 + dataSize);
  const view = new DataView(buffer);

  writeString(view, 0, 'RIFF');
  view.setUint32(4, fileSize, true);
  writeString(view, 8, 'WAVE');

  writeString(view, 12, 'fmt ');
  view.setUint32(16, 16, true);
  view.setUint16(20, 1, true);
  view.setUint16(22, NUM_CHANNELS, true);
  view.setUint32(24, SAMPLE_RATE, true);
  view.setUint32(28, byteRate, true);
  view.setUint16(32, blockAlign, true);
  view.setUint16(34, BITS_PER_SAMPLE, true);

  writeString(view, 36, 'data');
  view.setUint32(40, dataSize, true);

  const wavBytes = new Uint8Array(buffer);
  wavBytes.set(pcmBytes, 44);

  return new Blob([buffer], { type: 'audio/wav' });
}

function writeString(view: DataView, offset: number, str: string) {
  for (let i = 0; i < str.length; i++) {
    view.setUint8(offset + i, str.charCodeAt(i));
  }
}

const audioCache = new Map<string, Blob>();
const MAX_CACHE_ENTRIES = 50;

function getCacheKey(text: string, voiceName: string): string {
  return `${voiceName}:${text}`;
}

function addToCache(key: string, blob: Blob) {
  if (audioCache.size >= MAX_CACHE_ENTRIES) {
    const firstKey = audioCache.keys().next().value;
    if (firstKey) audioCache.delete(firstKey);
  }
  audioCache.set(key, blob);
}

export interface TtsOptions {
  voiceName?: string;
  signal?: AbortSignal;
}

export interface SpeakerConfig {
  speaker: string;
  voiceName: string;
}

export interface MultiSpeakerTtsOptions {
  signal?: AbortSignal;
}

async function getAccessToken(): Promise<string> {
  const {
    data: { session },
  } = await supabase.auth.getSession();

  if (session?.access_token) return session.access_token;

  const { data: refreshData, error } = await supabase.auth.refreshSession();
  if (error || !refreshData.session?.access_token) {
    throw new Error('Authentication required for TTS');
  }
  return refreshData.session.access_token;
}

export async function generateSpeech(text: string, options: TtsOptions = {}): Promise<Blob> {
  const { voiceName = 'Kore', signal } = options;

  const cacheKey = getCacheKey(text, voiceName);
  const cached = audioCache.get(cacheKey);
  if (cached) return cached;

  const accessToken = await getAccessToken();

  const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
  const res = await fetch(`${supabaseUrl}/functions/v1/text-to-speech`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${accessToken}`,
      apikey: import.meta.env.VITE_SUPABASE_ANON_KEY,
    },
    body: JSON.stringify({ text, voiceName }),
    signal,
  });

  if (!res.ok) {
    const errJson = await res.json().catch(() => ({ error: 'Unknown error' }));
    throw new Error(errJson.error || `TTS error (${res.status})`);
  }

  const { audioData } = await res.json();

  if (!audioData) {
    throw new Error('No audio data in TTS response');
  }

  const blob = pcmToWavBlob(audioData);
  addToCache(cacheKey, blob);
  return blob;
}

/**
 * Generate multi-speaker speech via the Edge Function.
 * Text must be in "Speaker: text" format.
 * speakers maps speaker names to voice names.
 */
export async function generateMultiSpeakerSpeech(
  text: string,
  speakers: SpeakerConfig[],
  options: MultiSpeakerTtsOptions = {}
): Promise<Blob> {
  const { signal } = options;

  const cacheKey = getCacheKey(text, speakers.map((s) => s.voiceName).join(','));
  const cached = audioCache.get(cacheKey);
  if (cached) return cached;

  const accessToken = await getAccessToken();

  const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
  const res = await fetch(`${supabaseUrl}/functions/v1/text-to-speech`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${accessToken}`,
      apikey: import.meta.env.VITE_SUPABASE_ANON_KEY,
    },
    body: JSON.stringify({ text, speakers }),
    signal,
  });

  if (!res.ok) {
    const errJson = await res.json().catch(() => ({ error: 'Unknown error' }));
    throw new Error(errJson.error || `TTS error (${res.status})`);
  }

  const { audioData } = await res.json();

  if (!audioData) {
    throw new Error('No audio data in TTS response');
  }

  const blob = pcmToWavBlob(audioData);
  addToCache(cacheKey, blob);
  return blob;
}
