import 'jsr:@supabase/functions-js/edge-runtime.d.ts';
import { createClient } from 'npm:@supabase/supabase-js@2';

// CORS – restrict to the production domain (fall back to '*' in development)
// Set ALLOWED_ORIGIN via `supabase secrets set ALLOWED_ORIGIN=https://your-app.com`
const ALLOWED_ORIGIN = Deno.env.get('ALLOWED_ORIGIN') || '*';

function corsHeaders(origin?: string | null) {
  const allowedOrigin =
    ALLOWED_ORIGIN === '*' ? '*' : origin === ALLOWED_ORIGIN ? ALLOWED_ORIGIN : '';

  return {
    'Access-Control-Allow-Origin': allowedOrigin,
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Client-Info, Apikey',
  };
}

interface TermData {
  id: string;
  term: string;
  termJa: string;
  category: string;
  chapter: number;
  order: number;
  difficulty: number;
  oneLiner: string;
  definition: string;
  mechanism?: string;
  analogy?: string;
  pitfall?: string;
  relatedTerms?: string[];
  storyContext?: string;
}

interface ChapterData {
  meta: {
    appName: string;
    fileDescription: string;
  };
  chapter: {
    id: number;
    title: string;
    subtitle: string;
    category: string;
    categoryName: string;
  };
  terms: TermData[];
}

Deno.serve(async (req: Request) => {
  const origin = req.headers.get('Origin');
  const headers = corsHeaders(origin);

  if (req.method === 'OPTIONS') {
    return new Response(null, { status: 200, headers });
  }

  try {
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    const { chapterData } = (await req.json()) as { chapterData: ChapterData };

    if (!chapterData || !chapterData.terms) {
      return new Response(JSON.stringify({ error: 'Invalid chapter data' }), {
        status: 400,
        headers: { ...headers, 'Content-Type': 'application/json' },
      });
    }

    const termsToInsert = chapterData.terms.map((term: TermData) => ({
      id: term.id,
      term: term.term,
      term_ja: term.termJa,
      chapter_id: term.chapter,
      order_index: term.order,
      difficulty: term.difficulty,
      one_liner: term.oneLiner,
      definition: term.definition,
      mechanism: term.mechanism || null,
      analogy: term.analogy || null,
      pitfall: term.pitfall || null,
      related_terms: term.relatedTerms || [],
      story_context: term.storyContext || null,
    }));

    const { error } = await supabase
      .from('terms')
      .upsert(termsToInsert, { onConflict: 'id' })
      .select();

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { ...headers, 'Content-Type': 'application/json' },
      });
    }

    return new Response(
      JSON.stringify({
        success: true,
        message: `Seeded ${termsToInsert.length} terms for chapter ${chapterData.chapter.id}`,
        count: termsToInsert.length,
      }),
      { headers: { ...headers, 'Content-Type': 'application/json' } }
    );
  } catch (err) {
    const origin = req.headers.get('Origin');
    return new Response(JSON.stringify({ error: String(err) }), {
      status: 500,
      headers: { ...corsHeaders(origin), 'Content-Type': 'application/json' },
    });
  }
});
