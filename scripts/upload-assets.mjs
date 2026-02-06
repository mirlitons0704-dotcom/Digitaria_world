import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

const supabaseUrl = 'https://erkvissuydjosstfhywf.supabase.co';
const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY;

if (!supabaseServiceKey) {
  console.error('Please set SUPABASE_SERVICE_KEY environment variable');
  console.log('You can find it in Supabase Dashboard > Settings > API > service_role key');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

const assetsDir = '/Users/takamimichiko/デジタリア';
const filesToUpload = [
  'c1_bit.png',
  'c1_happy.mp4',
  'c1_proud.mp4',
  'c1_think.mp4',
  'c2_bite.png',
  'c2_encourage.mp4',
  'c3_bfb.png',
  'c3_bfg.png',
  'c3_proud.mp4',
];

async function uploadFile(filename) {
  const filePath = path.join(assetsDir, filename);
  const fileBuffer = fs.readFileSync(filePath);
  
  const contentType = filename.endsWith('.mp4') ? 'video/mp4' : 'image/png';
  
  console.log(`Uploading ${filename}...`);
  
  const { data, error } = await supabase.storage
    .from('assets')
    .upload(filename, fileBuffer, {
      contentType,
      upsert: true,
    });
  
  if (error) {
    console.error(`  Error uploading ${filename}:`, error.message);
    return false;
  }
  
  console.log(`  ✓ Uploaded ${filename}`);
  return true;
}

async function main() {
  console.log('Starting upload to Supabase Storage...\n');
  
  let successCount = 0;
  for (const file of filesToUpload) {
    const success = await uploadFile(file);
    if (success) successCount++;
  }
  
  console.log(`\n✅ Uploaded ${successCount}/${filesToUpload.length} files`);
  
  // Print public URLs
  console.log('\nPublic URLs:');
  for (const file of filesToUpload) {
    const { data } = supabase.storage.from('assets').getPublicUrl(file);
    console.log(`  ${file}: ${data.publicUrl}`);
  }
}

main().catch(console.error);
