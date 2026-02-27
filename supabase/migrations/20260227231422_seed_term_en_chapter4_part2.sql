/*
  # Seed English translations for Chapter 4 terms (part 2 of 2)

  Translates the remaining 20 terms of Chapter 4 (terms 22–41).
  Topics: switch, truthy/falsy, operators, string ops, comments,
  debugging, code quality concepts.
*/

UPDATE terms SET
  one_liner_en = 'A construct that branches among multiple options',
  definition_en = 'A conditional construct that selects and executes code based on which of several possible values a variable holds.',
  mechanism_en = 'switch (value) { case "a": ...; break; case "b": ...; break; default: ...; }',
  analogy_en = 'A vending machine with buttons. The button you press (the value) determines which drink (code path) comes out.',
  pitfall_en = 'Forgetting break causes fall-through, where subsequent cases execute unintentionally. Always include break unless fall-through is deliberate.'
WHERE term = 'Switch statement' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A value treated as true in a condition',
  definition_en = 'Any value that evaluates to true when converted to a Boolean. Everything except false, 0, "", null, undefined, and NaN is truthy.',
  mechanism_en = 'if ("hello") evaluates as true. Non-empty strings, non-zero numbers, and objects are all truthy.',
  analogy_en = 'Having "something." If there is anything in the box, it counts as truthy—regardless of what it is.',
  pitfall_en = 'The string "0" and the string "false" are truthy because they are non-empty strings. This catches many people off guard.'
WHERE term = 'Truthy' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A value treated as false in a condition',
  definition_en = 'A value that evaluates to false when converted to a Boolean. In JavaScript there are exactly six: false, 0, "", null, undefined, and NaN.',
  mechanism_en = 'if (0) evaluates as false. These values are treated as "nothing" or "empty" in conditional checks.',
  analogy_en = 'Having "nothing." An empty box, zero dollars, a blank page—all treated as absent.',
  pitfall_en = 'An empty array [] and an empty object {} are not falsy—they are truthy. To check emptiness, inspect their length or keys.'
WHERE term = 'Falsy' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Symbols that compare values and return true or false',
  definition_en = 'Operators that compare two values and return a Boolean result: true or false. Includes ===, !==, <, >, <=, >=.',
  mechanism_en = '5 === 5 returns true; 5 > 3 returns true; 5 < 3 returns false. Used in conditional branches.',
  analogy_en = 'A balance scale. It compares two items and tells you which is heavier, lighter, or if they weigh the same.',
  pitfall_en = 'Be aware of == vs. ===. The == operator converts types before comparing; === compares both value and type. Default to ===.'
WHERE term = 'Comparison operator' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Symbols for AND, OR, and NOT operations',
  definition_en = 'Operators that perform logical operations: && (AND), || (OR), and ! (NOT).',
  mechanism_en = 'a && b is true only if both are true. a || b is true if either is true. !a flips true to false and vice versa.',
  analogy_en = 'Entry requirements. "18+ AND has a ticket" means both must be satisfied. "Student OR senior" means either one qualifies.',
  pitfall_en = '&& short-circuits: if the first operand is false, it skips evaluating the rest. This behavior is sometimes used as a coding trick.'
WHERE term = 'Logical operator' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Joining strings together',
  definition_en = 'The operation of combining two or more strings into one. Done with the + operator or template literals.',
  mechanism_en = '"Hello" + " " + "World" produces "Hello World". The array join() method can also concatenate strings.',
  analogy_en = 'Coupling train cars. Each car (string) links together to form one long train (a single string).',
  pitfall_en = 'Concatenating a number with a string converts the number to a string. 5 + "3" results in "53," not 8.'
WHERE term = 'Concatenation' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Embedding variables inside a string',
  definition_en = 'Inserting a variable''s value directly into a string. Uses template literals with the ${variable} syntax.',
  mechanism_en = '`Hello, ${name}!` embeds the value of name into the string. The string must be enclosed in backticks (`).',
  analogy_en = 'A fill-in-the-blank sentence. "My name is ___" gets the blank automatically filled with the variable''s value.',
  pitfall_en = 'Interpolation only works with backticks (`). Single quotes ('') and double quotes ("") do not support it.'
WHERE term = 'Interpolation' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A note in code that is not executed',
  definition_en = 'Explanatory text written inside code that the program ignores. Left as notes for your future self or other developers.',
  mechanism_en = '// marks a single-line comment; /* */ marks a multi-line comment. Used to describe intent or caveats.',
  analogy_en = 'Margin notes in a textbook. Written next to the main text (code) as personal reminders.',
  pitfall_en = 'Over-commenting is counterproductive. Make the code itself readable and keep comments to a minimum.'
WHERE term = 'Comment' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Finding and fixing bugs',
  definition_en = 'The process of locating and correcting defects (bugs) in a program. Tools include console.log and debugger breakpoints.',
  mechanism_en = 'Techniques include reading error messages, printing variable values, and pausing execution at breakpoints to inspect state.',
  analogy_en = 'Diagnosing and treating an illness. Observe the symptoms (errors), identify the cause (bug), and apply a cure (fix).',
  pitfall_en = 'Just because the code "seems to work" doesn''t mean it''s bug-free. Test a variety of cases to be thorough.'
WHERE term = 'Debug' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A marker that pauses program execution',
  definition_en = 'A point set during debugging where program execution temporarily halts, letting you inspect variable values at that moment.',
  mechanism_en = 'In browser DevTools, click a line number to set a breakpoint. Execution pauses automatically when it reaches that line.',
  analogy_en = 'Pausing a movie. You freeze the frame at a scene of interest to examine the details closely.',
  pitfall_en = 'Don''t leave breakpoints or debug code in production. Remove all debugging artifacts before deploying.'
WHERE term = 'Breakpoint' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'An error that occurs while a program is running',
  definition_en = 'An unexpected error situation that arises during program execution. Can be caught and handled gracefully with try/catch.',
  mechanism_en = 'Common triggers include opening a nonexistent file, dividing by zero, or accessing a property on undefined.',
  analogy_en = 'An unexpected mishap while cooking—like a pot boiling over. You need a plan for handling the situation.',
  pitfall_en = 'Silently swallowing exceptions hides problems. Always log the error or re-throw it so the issue doesn''t go unnoticed.'
WHERE term = 'Exception' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Dealing with errors gracefully',
  definition_en = 'Implementing mechanisms so that a program responds to errors without crashing. Ensures a smooth user experience even when things go wrong.',
  mechanism_en = 'Use try/catch to intercept errors, then notify the user, log the issue, or execute a fallback action.',
  analogy_en = 'Installing emergency exits. If a fire (error) breaks out, there is a safe evacuation (recovery) path prepared.',
  pitfall_en = 'Catching every error and doing nothing with it makes problems invisible. Handle errors at the appropriate level.'
WHERE term = 'Error handling' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A single line of source code',
  definition_en = 'One line in a source-code file. Error messages reference line numbers to pinpoint where something went wrong.',
  mechanism_en = 'Line numbers appear on the left side of a code editor. They are essential for locating errors.',
  analogy_en = 'A page and line number in a book. "Page 32, line 5" tells you exactly where to look.',
  pitfall_en = 'Lines that are too long hurt readability. Aim for roughly 80–120 characters per line.'
WHERE term = 'Line' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Commands given to a computer',
  definition_en = 'The specific directives telling a computer what to do. A program is composed of a sequence of instructions.',
  mechanism_en = 'Variable declarations, calculations, conditionals, loops—everything is an instruction to the computer, executed in order.',
  analogy_en = 'Steps in a recipe: "Chop the vegetables," "Put them in a pot," "Simmer." A sequence of concrete directives.',
  pitfall_en = 'Instructions in the wrong order produce wrong results. Always ensure the logical sequence is correct.'
WHERE term = 'Instructions' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A structure with levels of parent-child relationships',
  definition_en = 'A structure organized into levels of parent-child or superior-subordinate relationships. Seen in folder structures, DOM trees, and class inheritance.',
  mechanism_en = 'Often represented as a tree, branching from top to bottom.',
  analogy_en = 'An organizational chart. CEO at the top, then directors, managers, staff—a layered chain of command.',
  pitfall_en = 'Hierarchies that nest too deeply become hard to manage. Keep the depth reasonable.'
WHERE term = 'Hierarchy' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Splitting code into reusable, self-contained pieces',
  definition_en = 'A design principle of dividing a program into independent modules so that each can be reused and maintained separately.',
  mechanism_en = 'Separate code into files by function, then import only what you need. This limits the blast radius of changes.',
  analogy_en = 'LEGO bricks. Small pieces snap together to build something large, and each piece can be reused in other creations.',
  pitfall_en = 'Over-splitting makes things just as complicated. Find the right granularity for your modules.'
WHERE term = 'Modularity' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'How easy code is to read and understand',
  definition_en = 'A measure of how easily code can be read and comprehended by other developers—including your future self.',
  mechanism_en = 'Clear naming, consistent formatting, minimal but meaningful comments, and simple structure all improve readability.',
  analogy_en = 'A neatly handwritten letter. If it''s easy to read, the message comes across clearly.',
  pitfall_en = 'It''s tempting to think "it works, so it''s fine." But code you can''t read is code you can''t maintain.'
WHERE term = 'Readability' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The level of detail in how you split things up',
  definition_en = 'The degree to which things are divided. Considered when deciding how large or small functions and components should be.',
  mechanism_en = 'Finer granularity increases reusability but multiplies the number of pieces. Coarser granularity is simpler to manage but less flexible.',
  analogy_en = 'Sand versus rocks. Sand (fine granularity) can take any shape but there''s a lot of it. Rocks (coarse granularity) are easy to handle but rigid.',
  pitfall_en = 'There is no single "right" granularity. It depends on the project''s size and the team''s practices.'
WHERE term = 'Granularity' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Writing code directly in place',
  definition_en = 'Writing code directly where it''s needed rather than extracting it into a function or module. Also refers to embedding CSS or JS directly in HTML.',
  mechanism_en = 'Quick for small tasks, but the code cannot be reused and tends to be harder to maintain.',
  analogy_en = 'A disposable tool. Handy on the spot, but if you need the same thing again, you have to build it from scratch.',
  pitfall_en = 'As inline code accumulates, the same logic ends up scattered across multiple places, making updates painful.'
WHERE term = 'Inline coding' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Code organized by feature',
  definition_en = 'Code that is structured and grouped by feature (functionality). Related code lives together, making it easier to understand and maintain.',
  mechanism_en = 'Organize files and folders by feature—login, search, etc. Adding or removing a feature becomes straightforward.',
  analogy_en = 'A well-organized closet. "Shirts go here, pants go there"—grouping by category makes everything easy to find.',
  pitfall_en = 'Whether to organize by technical layer (controller, view, model) or by feature is a design decision that depends on the project.'
WHERE term = 'Feature aware code' AND chapter_id = 4;
