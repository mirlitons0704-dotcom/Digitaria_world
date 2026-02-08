import { supabase } from './supabase';

// Gemini TTS outputs PCM: 24kHz, 16-bit, mono
const SAMPLE_RATE = 24000;
const BITS_PER_SAMPLE = 16;
const NUM_CHANNELS = 1;

/**
 * Convert raw PCM (16-bit LE, 24kHz, mono) to a playable WAV Blob.
 */
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

  // RIFF header
  writeString(view, 0, 'RIFF');
  view.setUint32(4, fileSize, true);
  writeString(view, 8, 'WAVE');

  // fmt sub-chunk
  writeString(view, 12, 'fmt ');
  view.setUint32(16, 16, true); // sub-chunk size
  view.setUint16(20, 1, true); // PCM format
  view.setUint16(22, NUM_CHANNELS, true);
  view.setUint32(24, SAMPLE_RATE, true);
  view.setUint32(28, byteRate, true);
  view.setUint16(32, blockAlign, true);
  view.setUint16(34, BITS_PER_SAMPLE, true);

  // data sub-chunk
  writeString(view, 36, 'data');
  view.setUint32(40, dataSize, true);

  // Copy PCM data
  const wavBytes = new Uint8Array(buffer);
  wavBytes.set(pcmBytes, 44);

  return new Blob([buffer], { type: 'audio/wav' });
}

function writeString(view: DataView, offset: number, str: string) {
  for (let i = 0; i < str.length; i++) {
    view.setUint8(offset + i, str.charCodeAt(i));
  }
}

export interface TtsOptions {
  voiceName?: string;
  signal?: AbortSignal;
}

/**
 * Generate speech audio from text via Supabase Edge Function.
 * The Edge Function proxies the Gemini TTS API and keeps the API key server-side.
 * Returns a WAV Blob ready for playback.
 */
export async function generateSpeech(text: string, options: TtsOptions = {}): Promise<Blob> {
  const { voiceName = 'Kore', signal } = options;

  // Get the current session token for auth
  const {
    data: { session },
  } = await supabase.auth.getSession();

  const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
  const res = await fetch(`${supabaseUrl}/functions/v1/text-to-speech`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${session?.access_token ?? import.meta.env.VITE_SUPABASE_ANON_KEY}`,
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

  return pcmToWavBlob(audioData);
}
