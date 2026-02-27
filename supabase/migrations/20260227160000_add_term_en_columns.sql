-- Add English content columns to terms table
ALTER TABLE terms ADD COLUMN IF NOT EXISTS one_liner_en TEXT;
ALTER TABLE terms ADD COLUMN IF NOT EXISTS definition_en TEXT;
ALTER TABLE terms ADD COLUMN IF NOT EXISTS mechanism_en TEXT;
ALTER TABLE terms ADD COLUMN IF NOT EXISTS analogy_en TEXT;
ALTER TABLE terms ADD COLUMN IF NOT EXISTS pitfall_en TEXT;
