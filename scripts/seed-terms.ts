import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';

const supabaseUrl = process.env.VITE_SUPABASE_URL!;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY!;

const supabase = createClient(supabaseUrl, supabaseKey);

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
  chapter: { id: number; title: string };
  terms: TermData[];
}

async function seedChapter(chapterNum: number) {
  const filePath = path.join(__dirname, `../docs/chapter${chapterNum}-terms.json`);

  if (!fs.existsSync(filePath)) {
    console.log(`Chapter ${chapterNum} JSON not found, skipping...`);
    return 0;
  }

  const data: ChapterData = JSON.parse(fs.readFileSync(filePath, 'utf-8'));

  const termsToInsert = data.terms.map((term) => ({
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
    .upsert(termsToInsert, { onConflict: 'id' });

  if (error) {
    console.error(`Error seeding chapter ${chapterNum}:`, error.message);
    return 0;
  }

  console.log(`✓ Chapter ${chapterNum}: ${termsToInsert.length} terms seeded`);
  return termsToInsert.length;
}

async function main() {
  console.log('Starting term seeding...\n');

  let total = 0;
  for (let i = 1; i <= 16; i++) {
    total += await seedChapter(i);
  }

  console.log(`\nTotal: ${total} terms seeded`);
}

main().catch(console.error);
