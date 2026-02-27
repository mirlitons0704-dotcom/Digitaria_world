/*
  # Add English title columns to chapters and story_scenes

  ## Changes
  1. Add title_en, subtitle_en columns to chapters table
  2. Add title_en column to story_scenes table
  3. Seed English translations for all chapter titles/subtitles
  4. Seed English translations for all scene titles
*/

-- ==============================
-- 1. Add columns to chapters
-- ==============================
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'chapters' AND column_name = 'title_en'
  ) THEN
    ALTER TABLE chapters ADD COLUMN title_en text;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'chapters' AND column_name = 'subtitle_en'
  ) THEN
    ALTER TABLE chapters ADD COLUMN subtitle_en text;
  END IF;
END $$;

-- ==============================
-- 2. Add title_en column to story_scenes
-- ==============================
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'story_scenes' AND column_name = 'title_en'
  ) THEN
    ALTER TABLE story_scenes ADD COLUMN title_en text;
  END IF;
END $$;

-- ==============================
-- 3. Seed English chapter titles & subtitles
-- ==============================
UPDATE chapters SET title_en = 'Into the World of Computers',     subtitle_en = 'The Adventure of 0s and 1s Begins'         WHERE id = 1;
UPDATE chapters SET title_en = 'The Library of File Kingdom',     subtitle_en = 'What File Extensions Tell Us'               WHERE id = 2;
UPDATE chapters SET title_en = 'The Data Structure Lab',          subtitle_en = 'The Magic of Organizing Information'        WHERE id = 3;
UPDATE chapters SET title_en = 'The Programming Dojo',            subtitle_en = 'Learning the Art of Commands'               WHERE id = 4;
UPDATE chapters SET title_en = 'The Web Page Construction Site',  subtitle_en = 'Building Pages Like Building Houses'        WHERE id = 5;
UPDATE chapters SET title_en = 'The Sea of the Internet',         subtitle_en = 'Roads and Addresses That Connect the World' WHERE id = 6;
UPDATE chapters SET title_en = 'The JavaScript Dojo',             subtitle_en = 'The Art of Bringing the Web to Life'        WHERE id = 7;
UPDATE chapters SET title_en = 'The Component Academy',           subtitle_en = 'Building UIs by Combining Parts'            WHERE id = 8;
UPDATE chapters SET title_en = 'The UI Parts Workshop',           subtitle_en = 'Crafting User-Friendly Parts'               WHERE id = 9;
UPDATE chapters SET title_en = 'The Design Museum',               subtitle_en = 'Beautiful and Easy to Use'                  WHERE id = 10;
UPDATE chapters SET title_en = 'The Style Tailor',                subtitle_en = 'Efficiently Beautiful'                      WHERE id = 11;
UPDATE chapters SET title_en = 'The Terminal Cave',               subtitle_en = 'Don''t Fear the Black Screen'               WHERE id = 12;
UPDATE chapters SET title_en = 'The Package Delivery Center',     subtitle_en = 'Delivering Handy Tools'                     WHERE id = 13;
UPDATE chapters SET title_en = 'The Library of Time',             subtitle_en = 'Recording History, Rewinding Time'          WHERE id = 14;
UPDATE chapters SET title_en = 'The Server Castle',               subtitle_en = 'The Power Behind the Scenes'                WHERE id = 15;
UPDATE chapters SET title_en = 'The API Embassy',                 subtitle_en = 'A Bridge Connecting the World'              WHERE id = 16;
UPDATE chapters SET title_en = 'Epilogue',                        subtitle_en = 'Memory Garden'                              WHERE id = 17;

-- ==============================
-- 4. Seed English scene titles
-- ==============================

-- Chapter 1
UPDATE story_scenes SET title_en = 'Awakening'                        WHERE chapter_id = 1 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Meeting Bit'                      WHERE chapter_id = 1 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Meeting the Code Butterfly'       WHERE chapter_id = 1 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Bit''s Friends'                   WHERE chapter_id = 1 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'The Secret of Characters'         WHERE chapter_id = 1 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'The Language of Machines'         WHERE chapter_id = 1 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Closer to Human Language'         WHERE chapter_id = 1 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'A Bundle of Commands'             WHERE chapter_id = 1 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'Handy Tools'                      WHERE chapter_id = 1 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Software and Hardware'            WHERE chapter_id = 1 AND scene_number = 10;
UPDATE story_scenes SET title_en = 'Containers for Data'              WHERE chapter_id = 1 AND scene_number = 11;

-- Chapter 2
UPDATE story_scenes SET title_en = 'The Library Gate'                 WHERE chapter_id = 2 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'The Text-Only Room'               WHERE chapter_id = 2 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'The Web Room'                     WHERE chapter_id = 2 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'The Data Room'                    WHERE chapter_id = 2 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'The Image Room'                   WHERE chapter_id = 2 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'The Special Documents Room'       WHERE chapter_id = 2 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'The React Room'                   WHERE chapter_id = 2 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'File Information'                 WHERE chapter_id = 2 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'Configuration Files'              WHERE chapter_id = 2 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Combining Technologies'           WHERE chapter_id = 2 AND scene_number = 10;

-- Chapter 3
UPDATE story_scenes SET title_en = 'Invitation to the Lab'            WHERE chapter_id = 3 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'The Basic Types'                  WHERE chapter_id = 3 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Expressing "Nothing"'             WHERE chapter_id = 3 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Containers for Data'              WHERE chapter_id = 3 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Arrays: Drawers in a Row'         WHERE chapter_id = 3 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Objects: Labeled Shelves'         WHERE chapter_id = 3 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Special Collections'              WHERE chapter_id = 3 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'Blueprints for Types'             WHERE chapter_id = 3 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'Enumerations and Choices'         WHERE chapter_id = 3 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Advanced Data Structures'         WHERE chapter_id = 3 AND scene_number = 10;

-- Chapter 4
UPDATE story_scenes SET title_en = 'The Dojo Gate'                    WHERE chapter_id = 4 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Grammar Practice'                 WHERE chapter_id = 4 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Functions: The Art of Reuse'      WHERE chapter_id = 4 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'The Rules of Scope'               WHERE chapter_id = 4 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Repetition Training'              WHERE chapter_id = 4 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'The Art of Conditional Branching' WHERE chapter_id = 4 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'The World of True and False'      WHERE chapter_id = 4 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'String Techniques'                WHERE chapter_id = 4 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'Facing Errors'                    WHERE chapter_id = 4 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Good Coding Practices'            WHERE chapter_id = 4 AND scene_number = 10;

-- Chapter 5
UPDATE story_scenes SET title_en = 'To the Construction Site'         WHERE chapter_id = 5 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'The HTML Framework'               WHERE chapter_id = 5 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Naming Things'                    WHERE chapter_id = 5 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Writing Styles'                   WHERE chapter_id = 5 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'The Box Model'                    WHERE chapter_id = 5 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'The Magic of Layout'              WHERE chapter_id = 5 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Modern Layouts'                   WHERE chapter_id = 5 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'Responsive Design'                WHERE chapter_id = 5 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'Meaningful HTML'                  WHERE chapter_id = 5 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Embedding and Wrapping'           WHERE chapter_id = 5 AND scene_number = 10;

-- Chapter 6
UPDATE story_scenes SET title_en = 'Arriving at the Harbor'           WHERE chapter_id = 6 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'How Addresses Work'               WHERE chapter_id = 6 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'The Power of Links'               WHERE chapter_id = 6 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Rules of Communication'           WHERE chapter_id = 6 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Request and Response'             WHERE chapter_id = 6 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Status Codes'                     WHERE chapter_id = 6 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Other Protocols'                  WHERE chapter_id = 6 AND scene_number = 7;

-- Chapter 7
UPDATE story_scenes SET title_en = 'Entering the Dojo'               WHERE chapter_id = 7 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'The Art of Variables'             WHERE chapter_id = 7 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'The Art of Async'                 WHERE chapter_id = 7 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Handy Syntax'                     WHERE chapter_id = 7 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'The Art of Modules'               WHERE chapter_id = 7 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'The Art of Events'                WHERE chapter_id = 7 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'The Art of Timers'                WHERE chapter_id = 7 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'The Art of Array Operations'      WHERE chapter_id = 7 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'The Art of Debugging'             WHERE chapter_id = 7 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Node.js'                          WHERE chapter_id = 7 AND scene_number = 10;

-- Chapter 8
UPDATE story_scenes SET title_en = 'The Academy Gate'                 WHERE chapter_id = 8 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Component Basics'                 WHERE chapter_id = 8 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Passing Data Around'              WHERE chapter_id = 8 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'The Magic of Hooks'               WHERE chapter_id = 8 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Lifecycle'                        WHERE chapter_id = 8 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Conditions and Lists'             WHERE chapter_id = 8 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'State Management'                 WHERE chapter_id = 8 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'Custom Hooks'                     WHERE chapter_id = 8 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'Controlled Components'            WHERE chapter_id = 8 AND scene_number = 9;

-- Chapter 9
UPDATE story_scenes SET title_en = 'To the UI Parts Workshop'         WHERE chapter_id = 9 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Cards and Buttons'                WHERE chapter_id = 9 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Form Parts'                       WHERE chapter_id = 9 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Selection Parts'                  WHERE chapter_id = 9 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Notification Parts'               WHERE chapter_id = 9 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Overlay Parts'                    WHERE chapter_id = 9 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Loading and Waiting'              WHERE chapter_id = 9 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'Organizing Parts'                 WHERE chapter_id = 9 AND scene_number = 8;

-- Chapter 10
UPDATE story_scenes SET title_en = 'Invitation to the Museum'         WHERE chapter_id = 10 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'The Design Process'               WHERE chapter_id = 10 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Design Systems'                   WHERE chapter_id = 10 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'The World of Color'               WHERE chapter_id = 10 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'The Beauty of Typography'         WHERE chapter_id = 10 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Icons and Images'                 WHERE chapter_id = 10 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Designing States'                 WHERE chapter_id = 10 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'Decorations and Effects'          WHERE chapter_id = 10 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'The Magic of Motion'              WHERE chapter_id = 10 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Layout Fundamentals'              WHERE chapter_id = 10 AND scene_number = 10;

-- Chapter 11
UPDATE story_scenes SET title_en = 'The Tailor''s Shop'               WHERE chapter_id = 11 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Tailwind CSS'                     WHERE chapter_id = 11 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Component Libraries'              WHERE chapter_id = 11 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Sass and SCSS'                    WHERE chapter_id = 11 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'CSS Variables'                    WHERE chapter_id = 11 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Style Scoping'                    WHERE chapter_id = 11 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Reset and Normalize'              WHERE chapter_id = 11 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'Build Tools'                      WHERE chapter_id = 11 AND scene_number = 8;

-- Chapter 12
UPDATE story_scenes SET title_en = 'The Cave Entrance'                WHERE chapter_id = 12 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Development Environment'          WHERE chapter_id = 12 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Terminal and Shell'               WHERE chapter_id = 12 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'A New Terminal'                   WHERE chapter_id = 12 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Browser Developer Tools'          WHERE chapter_id = 12 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Debugging Techniques'             WHERE chapter_id = 12 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Updates and Errors'               WHERE chapter_id = 12 AND scene_number = 7;

-- Chapter 13
UPDATE story_scenes SET title_en = 'The Delivery Center'              WHERE chapter_id = 13 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'The World of npm'                 WHERE chapter_id = 13 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Yarn and Alternatives'            WHERE chapter_id = 13 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Dependencies'                     WHERE chapter_id = 13 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Configuration Files'              WHERE chapter_id = 13 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Version Control'                  WHERE chapter_id = 13 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Types of Environments'            WHERE chapter_id = 13 AND scene_number = 7;

-- Chapter 14
UPDATE story_scenes SET title_en = 'The Library of Time'              WHERE chapter_id = 14 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Repository'                       WHERE chapter_id = 14 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Branches'                         WHERE chapter_id = 14 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Commits'                          WHERE chapter_id = 14 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Push and Pull'                    WHERE chapter_id = 14 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Merging'                          WHERE chapter_id = 14 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Useful Commands'                  WHERE chapter_id = 14 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'Pull Requests'                    WHERE chapter_id = 14 AND scene_number = 8;

-- Chapter 15
UPDATE story_scenes SET title_en = 'Arriving at the Castle'           WHERE chapter_id = 15 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Front and Back'                   WHERE chapter_id = 15 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'Routing'                          WHERE chapter_id = 15 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'The Flow of Processing'           WHERE chapter_id = 15 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Middleware'                        WHERE chapter_id = 15 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'REST API'                         WHERE chapter_id = 15 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Inside a Request'                 WHERE chapter_id = 15 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'HTTP Methods'                     WHERE chapter_id = 15 AND scene_number = 8;

-- Chapter 16
UPDATE story_scenes SET title_en = 'Invitation to the Embassy'        WHERE chapter_id = 16 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'API Basics'                       WHERE chapter_id = 16 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'CRUD and HTTP Methods'            WHERE chapter_id = 16 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'GraphQL'                          WHERE chapter_id = 16 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'Real-Time Communication'          WHERE chapter_id = 16 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'Webhooks and Callbacks'           WHERE chapter_id = 16 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Limits and Controls'              WHERE chapter_id = 16 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'CORS and SDKs'                    WHERE chapter_id = 16 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'End of the Journey'               WHERE chapter_id = 16 AND scene_number = 9;

-- Chapter 17 (Epilogue)
UPDATE story_scenes SET title_en = 'Arriving at Memory Garden'        WHERE chapter_id = 17 AND scene_number = 1;
UPDATE story_scenes SET title_en = 'Gifts from the Butterflies'       WHERE chapter_id = 17 AND scene_number = 2;
UPDATE story_scenes SET title_en = 'The Courage to Face Errors'       WHERE chapter_id = 17 AND scene_number = 3;
UPDATE story_scenes SET title_en = 'Modern Syntax'                    WHERE chapter_id = 17 AND scene_number = 4;
UPDATE story_scenes SET title_en = 'The World of the Browser'         WHERE chapter_id = 17 AND scene_number = 5;
UPDATE story_scenes SET title_en = 'The Magic of Layout'              WHERE chapter_id = 17 AND scene_number = 6;
UPDATE story_scenes SET title_en = 'Adapting to Screen Sizes'         WHERE chapter_id = 17 AND scene_number = 7;
UPDATE story_scenes SET title_en = 'The Language of HTTP'             WHERE chapter_id = 17 AND scene_number = 8;
UPDATE story_scenes SET title_en = 'Delivering to the World'          WHERE chapter_id = 17 AND scene_number = 9;
UPDATE story_scenes SET title_en = 'Getting Discovered'               WHERE chapter_id = 17 AND scene_number = 10;
UPDATE story_scenes SET title_en = 'For Everyone'                     WHERE chapter_id = 17 AND scene_number = 11;
UPDATE story_scenes SET title_en = 'End of the Journey, A New Beginning' WHERE chapter_id = 17 AND scene_number = 12;
UPDATE story_scenes SET title_en = 'To the New World'                 WHERE chapter_id = 17 AND scene_number = 13;

-- Notify PostgREST to pick up new columns
NOTIFY pgrst, 'reload schema';
