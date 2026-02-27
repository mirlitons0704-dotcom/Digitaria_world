/*
  # Seed English translations for Chapter 17 / Epilogue terms (Part 1: terms 1-10)
  
  Chapter 17 (Epilogue) covers miscellaneous and advanced concepts.
  Updates the first 10 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'A structure for catching and handling errors',
  definition_en = 'A syntax that wraps potentially error-prone code in a try block. If an error occurs, the catch block handles it gracefully instead of crashing.',
  mechanism_en = 'Written as try { risky code } catch (error) { handle error }. An optional finally block runs cleanup code regardless of the outcome.',
  analogy_en = 'A safety net under a trapeze. If the acrobat falls (error), the net (catch) catches them safely.',
  pitfall_en = 'Don''t wrap everything in try/catch indiscriminately. Use it around operations that genuinely might fail.'
WHERE term = 'Try/catch' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Two ways to represent "nothing" in JavaScript',
  definition_en = 'null means "intentionally empty." undefined means "no value has been assigned yet." They look similar but have different meanings.',
  mechanism_en = 'let x; gives undefined. let y = null; is explicitly empty. typeof null returns ''object'' (a historical bug in JavaScript).',
  analogy_en = 'An empty box (null) versus no box at all (undefined).',
  pitfall_en = 'With ==, null == undefined is true. With ===, it''s false. Always use strict equality (===).'
WHERE term = 'Null / Undefined' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Safely accessing nested properties with ?.',
  definition_en = 'A syntax that lets you access deeply nested object properties without throwing an error if an intermediate value is null or undefined.',
  mechanism_en = 'user?.address?.city returns undefined instead of throwing if address is null or undefined. No error, no crash.',
  analogy_en = 'Knocking cautiously on each door. "Anyone here?" — checking before entering each room in sequence.',
  pitfall_en = 'Convenient for safety checks, but overuse can silently mask bugs that should be caught and fixed.'
WHERE term = 'Optional chaining' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'A fallback operator for null/undefined only (??)',
  definition_en = 'An operator that returns the right-hand value only when the left-hand side is null or undefined. Unlike ||, it treats 0 and empty strings as valid values.',
  mechanism_en = 'value ?? ''default'' returns ''default'' only when value is null or undefined. 0 ?? 5 returns 0.',
  analogy_en = '"Only use the backup when it''s truly empty." Zero yen is still a value; unset is truly empty.',
  pitfall_en = '|| treats all falsy values (0, '''', false) as triggers for the fallback. ?? only triggers on null/undefined.'
WHERE term = 'Nullish coalescing' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'A string that can embed variables using backticks',
  definition_en = 'A string enclosed in backticks (`) that allows embedding variables and expressions using ${} syntax. Also supports multi-line strings natively.',
  mechanism_en = 'Written as `Hello, ${name}!`. Much more readable than concatenation with +.',
  analogy_en = 'A fill-in-the-blank form. "Hello, ___" with the blank automatically filled in by the variable.',
  pitfall_en = 'Don''t confuse backticks (`) with single quotes (''). Only backticks support template literal features.'
WHERE term = 'Template literal' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'A one-line if-else: condition ? yes : no',
  definition_en = 'A compact operator that evaluates a condition and returns one of two values. A shorthand for simple if-else statements.',
  mechanism_en = 'Written as isLoggedIn ? ''Welcome'' : ''Please login''. Returns the first value if true, the second if false.',
  analogy_en = 'A two-choice quiz. "If correct, answer A; if wrong, answer B" — expressed in a single line.',
  pitfall_en = 'Nesting ternary operators makes code very hard to read. Use if-else for complex conditions.'
WHERE term = 'Ternary operator' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Persistent key-value storage in the browser',
  definition_en = 'A browser API that stores key-value pairs persistently. Data survives browser restarts and page refreshes.',
  mechanism_en = 'Use localStorage.setItem(''key'', ''value'') to save and getItem(''key'') to retrieve. Only stores strings.',
  analogy_en = 'A desk drawer in the browser. Put something in, and it stays there even after you close the browser.',
  pitfall_en = 'Objects must be converted with JSON.stringify() before saving. Use JSON.parse() when reading them back.'
WHERE term = 'localStorage' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'A flexible one-dimensional CSS layout system',
  definition_en = 'A CSS layout model that arranges elements in a single direction (row or column) with flexible spacing and alignment controls.',
  mechanism_en = 'Enabled with display: flex;. Control alignment with justify-content and align-items.',
  analogy_en = 'Dancers lining up on stage. You can direct them to "line up horizontally" or "center together."',
  pitfall_en = 'Flexbox is one-dimensional (row or column). For two-dimensional layouts (rows AND columns), use CSS Grid.'
WHERE term = 'Flexbox' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'A two-dimensional CSS layout system',
  definition_en = 'A CSS layout model that arranges elements in both rows and columns simultaneously. Ideal for complex page layouts.',
  mechanism_en = 'Enabled with display: grid;. Define the grid structure with grid-template-columns and grid-template-rows.',
  analogy_en = 'A spreadsheet. Elements are placed into cells defined by rows and columns.',
  pitfall_en = 'Use the right tool: Flexbox for one-dimensional flow, Grid for two-dimensional layouts.'
WHERE term = 'Grid (CSS)' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Controls which element appears on top when overlapping',
  definition_en = 'A CSS property that determines the stacking order of overlapping elements. Higher values appear in front of lower values.',
  mechanism_en = 'Set with z-index: 100;. Only works on elements with a position value other than static.',
  analogy_en = 'Stacking sheets of paper. The sheet with the highest z-index sits on top of the pile.',
  pitfall_en = 'z-index values tend to inflate (9999, 99999...). Use planned, incremental values (10, 20, 30) instead.'
WHERE term = 'z-index' AND chapter_id = 17;
