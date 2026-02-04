/*
  # DIGITARIA Code Journey - Database Schema
  
  ## Overview
  This migration creates the complete database structure for the DIGITARIA 
  programming terms learning app with story mode and butterfly collection.
  
  ## 1. New Tables
  
  ### characters
  - `id` (uuid, primary key) - Unique character identifier
  - `name` (text) - Character name (e.g., "ビットくん")
  - `name_en` (text) - English name
  - `role` (text) - Character role (e.g., "メインガイド")
  - `personality` (text) - Personality description
  - `speech_style` (text) - How they speak
  - `appearance` (text) - Visual description
  - `chapter_appearance` (integer) - First chapter appearance
  
  ### chapters
  - `id` (integer, primary key) - Chapter number (1-16)
  - `title` (text) - Japanese title
  - `subtitle` (text) - Japanese subtitle
  - `category` (text) - Category slug
  - `category_name` (text) - Japanese category name
  - `category_icon` (text) - Icon name
  - `description` (text) - Chapter description
  - `guide_id` (uuid, FK) - Main guide character
  - `support_guide_id` (uuid, FK) - Support guide character
  - `term_count` (integer) - Number of terms in chapter
  
  ### terms
  - `id` (text, primary key) - Term slug (e.g., "binary")
  - `term` (text) - English term
  - `term_ja` (text) - Japanese term
  - `chapter_id` (integer, FK) - Chapter this term belongs to
  - `order_index` (integer) - Order within chapter
  - `difficulty` (integer) - Difficulty level (1-3)
  - `one_liner` (text) - Short description
  - `definition` (text) - Full definition
  - `mechanism` (text) - How it works
  - `analogy` (text) - Real-world analogy
  - `pitfall` (text) - Common mistakes
  - `related_terms` (text[]) - Related term IDs
  - `story_context` (text) - Story scene context
  
  ### story_scenes
  - `id` (uuid, primary key) - Scene identifier
  - `chapter_id` (integer, FK) - Chapter this scene belongs to
  - `scene_number` (integer) - Scene order within chapter
  - `title` (text) - Scene title
  - `content` (text) - Full narrative content
  - `terms_introduced` (text[]) - Terms introduced in this scene
  - `character_ids` (uuid[]) - Characters appearing in scene
  
  ### user_profiles
  - `id` (uuid, primary key, FK auth.users) - User ID
  - `display_name` (text) - User's display name
  - `avatar_url` (text) - Avatar URL
  - `total_butterflies` (integer) - Total butterflies collected
  - `current_chapter` (integer) - Current chapter progress
  
  ### user_term_progress
  - `id` (uuid, primary key) - Progress record ID
  - `user_id` (uuid, FK) - User ID
  - `term_id` (text, FK) - Term ID
  - `mastery_level` (integer) - 0=unseen, 1=seen, 2=learning, 3=mastered
  - `times_reviewed` (integer) - Review count
  - `last_reviewed_at` (timestamptz) - Last review time
  - `butterfly_stage` (text) - light/egg/larva/pupa/butterfly
  
  ### user_chapter_progress
  - `id` (uuid, primary key) - Progress record ID
  - `user_id` (uuid, FK) - User ID
  - `chapter_id` (integer, FK) - Chapter ID
  - `is_unlocked` (boolean) - Whether chapter is accessible
  - `is_completed` (boolean) - Whether chapter is finished
  - `terms_mastered` (integer) - Number of terms mastered
  - `story_progress` (integer) - Current scene number
  
  ### quiz_history
  - `id` (uuid, primary key) - Quiz record ID
  - `user_id` (uuid, FK) - User ID
  - `quiz_type` (text) - 'term_to_definition' or 'definition_to_term'
  - `chapter_id` (integer) - Chapter tested (null for mixed)
  - `score` (integer) - Correct answers
  - `total_questions` (integer) - Total questions
  - `completed_at` (timestamptz) - Completion time
  
  ## 2. Security
  - RLS enabled on all tables
  - Public read access for content tables (characters, chapters, terms, story_scenes)
  - User-specific access for progress tables
  
  ## 3. Notes
  - Characters and story data will be seeded separately
  - Terms data imported from JSON files
*/

-- Create characters table
CREATE TABLE IF NOT EXISTS characters (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  name_en text,
  role text NOT NULL,
  personality text,
  speech_style text,
  appearance text,
  chapter_appearance integer DEFAULT 1,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE characters ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Characters are publicly readable"
  ON characters FOR SELECT
  TO authenticated, anon
  USING (true);

-- Create chapters table
CREATE TABLE IF NOT EXISTS chapters (
  id integer PRIMARY KEY,
  title text NOT NULL,
  subtitle text,
  category text NOT NULL,
  category_name text NOT NULL,
  category_icon text DEFAULT 'book',
  description text,
  guide_id uuid REFERENCES characters(id),
  support_guide_id uuid REFERENCES characters(id),
  term_count integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Chapters are publicly readable"
  ON chapters FOR SELECT
  TO authenticated, anon
  USING (true);

-- Create terms table
CREATE TABLE IF NOT EXISTS terms (
  id text PRIMARY KEY,
  term text NOT NULL,
  term_ja text NOT NULL,
  chapter_id integer NOT NULL REFERENCES chapters(id),
  order_index integer NOT NULL,
  difficulty integer DEFAULT 1 CHECK (difficulty >= 1 AND difficulty <= 3),
  one_liner text NOT NULL,
  definition text NOT NULL,
  mechanism text,
  analogy text,
  pitfall text,
  related_terms text[] DEFAULT '{}',
  story_context text,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE terms ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Terms are publicly readable"
  ON terms FOR SELECT
  TO authenticated, anon
  USING (true);

-- Create index for faster chapter lookups
CREATE INDEX IF NOT EXISTS idx_terms_chapter ON terms(chapter_id);
CREATE INDEX IF NOT EXISTS idx_terms_order ON terms(chapter_id, order_index);

-- Create story_scenes table
CREATE TABLE IF NOT EXISTS story_scenes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id integer NOT NULL REFERENCES chapters(id),
  scene_number integer NOT NULL,
  title text,
  content text NOT NULL,
  terms_introduced text[] DEFAULT '{}',
  character_ids uuid[] DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  UNIQUE(chapter_id, scene_number)
);

ALTER TABLE story_scenes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Story scenes are publicly readable"
  ON story_scenes FOR SELECT
  TO authenticated, anon
  USING (true);

CREATE INDEX IF NOT EXISTS idx_story_scenes_chapter ON story_scenes(chapter_id);

-- Create user_profiles table
CREATE TABLE IF NOT EXISTS user_profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name text,
  avatar_url text,
  total_butterflies integer DEFAULT 0,
  current_chapter integer DEFAULT 1,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own profile"
  ON user_profiles FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON user_profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
  ON user_profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- Create user_term_progress table
CREATE TABLE IF NOT EXISTS user_term_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  term_id text NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
  mastery_level integer DEFAULT 0 CHECK (mastery_level >= 0 AND mastery_level <= 3),
  times_reviewed integer DEFAULT 0,
  last_reviewed_at timestamptz,
  butterfly_stage text DEFAULT 'none' CHECK (butterfly_stage IN ('none', 'light', 'egg', 'larva', 'pupa', 'butterfly')),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(user_id, term_id)
);

ALTER TABLE user_term_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own term progress"
  ON user_term_progress FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own term progress"
  ON user_term_progress FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own term progress"
  ON user_term_progress FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE INDEX IF NOT EXISTS idx_user_term_progress_user ON user_term_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_term_progress_term ON user_term_progress(term_id);

-- Create user_chapter_progress table
CREATE TABLE IF NOT EXISTS user_chapter_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  chapter_id integer NOT NULL REFERENCES chapters(id) ON DELETE CASCADE,
  is_unlocked boolean DEFAULT false,
  is_completed boolean DEFAULT false,
  terms_mastered integer DEFAULT 0,
  story_progress integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(user_id, chapter_id)
);

ALTER TABLE user_chapter_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own chapter progress"
  ON user_chapter_progress FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own chapter progress"
  ON user_chapter_progress FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own chapter progress"
  ON user_chapter_progress FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE INDEX IF NOT EXISTS idx_user_chapter_progress_user ON user_chapter_progress(user_id);

-- Create quiz_history table
CREATE TABLE IF NOT EXISTS quiz_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  quiz_type text NOT NULL CHECK (quiz_type IN ('term_to_definition', 'definition_to_term', 'mixed')),
  chapter_id integer REFERENCES chapters(id),
  score integer NOT NULL DEFAULT 0,
  total_questions integer NOT NULL,
  completed_at timestamptz DEFAULT now()
);

ALTER TABLE quiz_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own quiz history"
  ON quiz_history FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own quiz history"
  ON quiz_history FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE INDEX IF NOT EXISTS idx_quiz_history_user ON quiz_history(user_id);

-- Function to automatically create user profile on signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO user_profiles (id, display_name)
  VALUES (NEW.id, COALESCE(NEW.raw_user_meta_data->>'display_name', 'Traveler'));
  
  -- Unlock chapter 1 by default
  INSERT INTO user_chapter_progress (user_id, chapter_id, is_unlocked)
  VALUES (NEW.id, 1, true);
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on user signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Function to update timestamps
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS trigger AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for updated_at
CREATE TRIGGER update_user_profiles_updated_at
  BEFORE UPDATE ON user_profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_user_term_progress_updated_at
  BEFORE UPDATE ON user_term_progress
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_user_chapter_progress_updated_at
  BEFORE UPDATE ON user_chapter_progress
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
