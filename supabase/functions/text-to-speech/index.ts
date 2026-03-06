import 'jsr:@supabase/functions-js/edge-runtime.d.ts';
import { createClient } from 'jsr:@supabase/supabase-js@2';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Client-Info, Apikey',
};

// ---------------------------------------------------------------------------
// Simple in-memory rate limiter (per-user, per Edge Function instance)
// ---------------------------------------------------------------------------
const RATE_LIMIT_WINDOW_MS = 60_000; // 1 minute
const RATE_LIMIT_MAX = 20; // max requests per window

const rateLimitMap = new Map<string, { count: number; resetAt: number }>();

function isRateLimited(userId: string): boolean {
  const now = Date.now();
  const entry = rateLimitMap.get(userId);

  if (!entry || now > entry.resetAt) {
    rateLimitMap.set(userId, { count: 1, resetAt: now + RATE_LIMIT_WINDOW_MS });
    return false;
  }

  entry.count += 1;
  return entry.count > RATE_LIMIT_MAX;
}

// ---------------------------------------------------------------------------
// Gemini TTS configuration
// ---------------------------------------------------------------------------
const TTS_MODEL = 'gemini-2.5-flash-preview-tts';
const TTS_ENDPOINT = `https://generativelanguage.googleapis.com/v1beta/models/${TTS_MODEL}:generateContent`;

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { status: 200, headers: corsHeaders });
  }

  if (req.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  try {
    // ------ Authenticate the caller (optional) ------
    const authHeader = req.headers.get('Authorization') ?? '';
    const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? '';
    const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';

    console.log('TTS request received, auth header present:', !!authHeader);

    const supabase = createClient(supabaseUrl, serviceRoleKey);
    const token = authHeader.replace(/^Bearer\s+/i, '');

    let userId = 'anonymous';

    // Try to authenticate, but allow anonymous access
    if (token && !token.includes('anon')) {
      const {
        data: { user },
      } = await supabase.auth.getUser(token);

      if (user) {
        userId = user.id;
      }
    }

    // Use IP address for anonymous rate limiting
    if (userId === 'anonymous') {
      const forwardedFor = req.headers.get('x-forwarded-for');
      const ip = forwardedFor?.split(',')[0]?.trim() || 'unknown';
      userId = `anon_${ip}`;
    }

    console.log('Auth OK, userId:', userId);

    // ------ Rate limit ------
    if (isRateLimited(userId)) {
      return new Response(JSON.stringify({ error: 'Too many requests. Please wait a moment.' }), {
        status: 429,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // ------ Validate Gemini key ------
    const geminiApiKey = Deno.env.get('GEMINI_API_KEY');
    if (!geminiApiKey) {
      return new Response(JSON.stringify({ error: 'GEMINI_API_KEY is not configured' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const {
      text,
      voiceName = 'Kore',
      speakers,
    } = (await req.json()) as {
      text: string;
      voiceName?: string;
      speakers?: { speaker: string; voiceName: string }[];
    };

    if (!text || typeof text !== 'string') {
      return new Response(JSON.stringify({ error: 'text field is required' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Limit input length to prevent abuse (max ~5000 chars ≈ a long scene)
    if (text.length > 5000) {
      return new Response(JSON.stringify({ error: 'Text too long (max 5000 characters)' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // ------ Call Gemini TTS API ------
    const isMultiSpeaker = Array.isArray(speakers) && speakers.length >= 2;

    let ttsPrompt: string;
    let speechConfig: Record<string, unknown>;

    if (isMultiSpeaker) {
      // Multi-speaker mode: text is in "Speaker: text" format
      ttsPrompt = `TTS the following conversation:\n${text}`;
      speechConfig = {
        multiSpeakerVoiceConfig: {
          speakerVoiceConfigs: speakers!.map((s) => ({
            speaker: s.speaker,
            voiceConfig: {
              prebuiltVoiceConfig: { voiceName: s.voiceName },
            },
          })),
        },
      };
    } else {
      // Single-speaker mode (backward compatible)
      ttsPrompt = `Read the following text aloud in a natural, expressive voice:\n\n${text}`;
      speechConfig = {
        voiceConfig: {
          prebuiltVoiceConfig: { voiceName },
        },
      };
    }

    const requestBody = {
      contents: [{ parts: [{ text: ttsPrompt }] }],
      generationConfig: {
        responseModalities: ['AUDIO'],
        speechConfig,
      },
    };

    console.log(
      '[TTS] Calling Gemini API',
      isMultiSpeaker ? `multi-speaker (${speakers!.length})` : `voice: ${voiceName}`,
      'text length:',
      text.length
    );

    const geminiRes = await fetch(`${TTS_ENDPOINT}?key=${geminiApiKey}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(requestBody),
    });

    console.log('[TTS] Gemini API response status:', geminiRes.status);

    if (!geminiRes.ok) {
      const errText = await geminiRes.text().catch(() => 'Unknown error');
      console.error('[TTS] Gemini API error:', geminiRes.status, errText);
      return new Response(
        JSON.stringify({
          error: `Gemini API error (${geminiRes.status})`,
          detail: errText,
        }),
        {
          status: geminiRes.status,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      );
    }

    const geminiJson = await geminiRes.json();
    console.log('[TTS] Gemini response structure:', JSON.stringify(Object.keys(geminiJson)));

    const audioData = geminiJson?.candidates?.[0]?.content?.parts?.[0]?.inlineData?.data;

    if (!audioData) {
      return new Response(JSON.stringify({ error: 'No audio data in Gemini response' }), {
        status: 502,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Return the base64 PCM audio data
    return new Response(JSON.stringify({ audioData }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: String(err) }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
