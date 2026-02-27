/*
  # Seed English translations for Chapter 7 terms (part 2 of 2)

  Translates the remaining 20 terms of Chapter 7 (terms 21–40).
  Topics: this, events, timers, array methods, console, typeof,
  Node.js, Zod, utilities, parsing.
*/

UPDATE terms SET
  one_liner_en = 'A special keyword that refers to "itself"',
  definition_en = 'A special keyword inside functions and methods that refers to the object that called the function.',
  mechanism_en = 'What "this" points to depends on how the function is called. In a method call, it refers to the owning object; in a standalone call, it is undefined (in strict mode).',
  analogy_en = 'The word "I." Who it refers to changes depending on who says it.',
  pitfall_en = 'Arrow functions do not have their own "this"—they inherit from the surrounding scope. Understanding this distinction is critical.'
WHERE term = 'This keyword' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A user action or system occurrence in the browser',
  definition_en = 'Something that happens in the browser—a click, key press, mouse movement, etc. JavaScript can detect and respond to events.',
  mechanism_en = 'When an event fires, an event object is created and passed to registered handlers.',
  analogy_en = 'A doorbell. Someone rings it (event fires), and you go to greet them (handle the event).',
  pitfall_en = 'There are many event types: click, change, submit, keydown, load, and more. Choose the right one for your use case.'
WHERE term = 'Event' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A mechanism that "listens" for events',
  definition_en = 'A mechanism that registers a function to be called whenever a specific event occurs.',
  mechanism_en = 'element.addEventListener(''click'', handler) to register; removeEventListener to unregister.',
  analogy_en = 'A lookout. You say, "Let me know when someone clicks." When it happens, the lookout reports back.',
  pitfall_en = 'Always remove listeners when they are no longer needed. Forgetting to do so can cause memory leaks.'
WHERE term = 'Event listener' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'The function that runs when an event fires',
  definition_en = 'A function invoked when an event occurs. It receives the event object as an argument.',
  mechanism_en = 'function handleClick(event) { ... } — defined and registered via addEventListener.',
  analogy_en = 'A response manual. "When this happens, do that"—a predefined set of instructions.',
  pitfall_en = 'Heavy processing inside a handler can block the UI. Offload to async operations when needed.'
WHERE term = 'Event handler' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Stopping the browser''s default action',
  definition_en = 'A method that cancels an event''s default behavior, such as navigating on a link click or submitting a form.',
  mechanism_en = 'Call event.preventDefault() inside the handler. Common use: preventing a form submit from reloading the page.',
  analogy_en = '"Please don''t do the usual thing." Like stopping an automatic door from opening.',
  pitfall_en = 'Use only when necessary. Overusing it can break the behavior users expect.'
WHERE term = 'Prevent default' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Runs a function once after a delay',
  definition_en = 'A timer function that executes a callback once after a specified number of milliseconds.',
  mechanism_en = 'setTimeout(callback, 1000) runs the callback after 1 second. clearTimeout cancels it.',
  analogy_en = 'An alarm. "Wake me in 5 minutes"—it rings once after the set time.',
  pitfall_en = 'The delay is a minimum, not exact. For precision timing, setTimeout is not ideal.'
WHERE term = 'setTimeout' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Runs a function repeatedly at a fixed interval',
  definition_en = 'A timer function that executes a callback repeatedly at a specified millisecond interval.',
  mechanism_en = 'setInterval(callback, 1000) runs the callback every second. clearInterval stops it.',
  analogy_en = 'A snooze alarm. It keeps ringing at regular intervals until you explicitly stop it.',
  pitfall_en = 'If a component unmounts but the interval keeps running, it causes leaks. Always clean up.'
WHERE term = 'setInterval' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Transforms each array element into a new array',
  definition_en = 'A method that applies a function to every element in an array and returns a new array of the results.',
  mechanism_en = '[1, 2, 3].map(x => x * 2) returns [2, 4, 6]. The original array is not modified.',
  analogy_en = 'A factory line. Each raw material (element) is processed (transformed) into a finished product (new array).',
  pitfall_en = 'map() always returns a new array. If you don''t need the return value, use forEach instead.'
WHERE term = 'Map function' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Keeps only the elements that pass a test',
  definition_en = 'A method that tests each element against a condition and returns a new array containing only the elements that pass.',
  mechanism_en = '[1, 2, 3, 4].filter(x => x > 2) returns [3, 4]. The original array is not modified.',
  analogy_en = 'A sieve. Only items that meet the size requirement pass through; the rest are filtered out.',
  pitfall_en = 'If no elements match, it returns an empty array (not an error).'
WHERE term = 'Filter function' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Condenses an array down to a single value',
  definition_en = 'A method that processes array elements in sequence and accumulates them into a single result—a sum, object, array, or anything else.',
  mechanism_en = '[1, 2, 3].reduce((acc, cur) => acc + cur, 0) returns 6. The second argument is the initial value.',
  analogy_en = 'Building a snowball. Each roll adds more snow (elements), and you end up with one big snowball (result).',
  pitfall_en = 'Omitting the initial value uses the first element as the starting accumulator. On an empty array this throws an error.'
WHERE term = 'Reduce function' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Executes a function on each array element',
  definition_en = 'A method that runs a given function on every element of an array. It has no return value and is used for side effects.',
  mechanism_en = '[1, 2, 3].forEach(x => console.log(x)) logs each element. Unlike map, it does not create a new array.',
  analogy_en = 'Roll call. You go through each person one by one—but you''re not creating a new list.',
  pitfall_en = 'forEach cannot be stopped midway (break is not supported). If you need early exit, use for...of instead.'
WHERE term = 'ForEach' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Returns the first element that matches a condition',
  definition_en = 'A method that searches an array and returns the first element satisfying a condition. Returns undefined if nothing matches.',
  mechanism_en = '[1, 2, 3].find(x => x > 1) returns 2. The search stops as soon as a match is found.',
  analogy_en = 'Searching for a lost item. Once you find something that matches, the search is over.',
  pitfall_en = 'Handle the possible undefined return. Use optional chaining or conditional checks.'
WHERE term = 'Find' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Prints values to the browser''s developer console',
  definition_en = 'A method that outputs messages and values to the browser''s developer tools console. Essential for debugging.',
  mechanism_en = 'console.log(''Hello''); or console.log(variable); displays values for inspection.',
  analogy_en = 'Scribbling notes to yourself. You jot down the program''s intermediate state where only you can see it.',
  pitfall_en = 'Don''t leave console.log in production code. Remove debug logs or use a proper logging system.'
WHERE term = 'Console log' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A method that runs automatically when a property is accessed',
  definition_en = 'A getter method on an object that executes automatically when a property is read.',
  mechanism_en = 'get propName() { return this._prop; } — accessing obj.propName triggers the getter.',
  analogy_en = 'An automatic door. Simply approaching (accessing) triggers it to open (execute).',
  pitfall_en = 'Expensive computations in a getter run every time the property is accessed, potentially hurting performance.'
WHERE term = 'Get' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'An operator that reveals a value''s type',
  definition_en = 'An operator that returns a string indicating the data type of a value: ''string'', ''number'', ''boolean'', ''object'', etc.',
  mechanism_en = 'typeof 42 returns ''number''; typeof ''hello'' returns ''string''.',
  analogy_en = 'A material inspector. "This is wood," "this is metal"—it identifies what something is made of (its type).',
  pitfall_en = 'typeof null returns ''object''—a historical bug in JavaScript. Use === null for null checks instead.'
WHERE term = 'Typeof' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A JavaScript runtime for servers',
  definition_en = 'An environment that lets JavaScript run outside the browser. Used for server-side development, CLI tools, and build systems.',
  mechanism_en = 'Powered by the V8 engine (same as Chrome). Libraries are managed through npm (Node Package Manager).',
  analogy_en = 'JavaScript on a business trip. It left its usual workplace (the browser) and can now work on the server too.',
  pitfall_en = 'Browser APIs (window, document) are not available in Node.js. Be aware of the environmental differences.'
WHERE term = 'Node.js' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A runtime type-validation library for TypeScript',
  definition_en = 'A TypeScript library that validates data types at runtime. Used for validating API responses and form inputs.',
  mechanism_en = 'z.object({ name: z.string() }).parse(data) validates the data. Throws an exception if the shape is wrong.',
  analogy_en = 'An immigration officer. "Is your passport (type) valid?" If not, entry is denied.',
  pitfall_en = 'TypeScript types disappear at runtime. Zod fills that gap by providing runtime type checking.'
WHERE term = 'Zod' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Loading an external library into your code',
  definition_en = 'Importing an external library installed via npm (or similar) so you can use it in your own code.',
  mechanism_en = 'import React from ''react''; — specify the package name to import.',
  analogy_en = 'Borrowing a tool. Instead of building it yourself, you borrow a ready-made tool (library).',
  pitfall_en = 'Watch your bundle size. Import only the specific functions you need rather than entire libraries.'
WHERE term = 'Library import' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A general-purpose helper function',
  definition_en = 'A reusable function not tied to a specific feature—date formatting, array manipulation, and the like.',
  mechanism_en = 'Typically organized in a utils/ folder. Libraries like lodash are well-known utility collections.',
  analogy_en = 'A Swiss Army knife. A versatile tool useful in many different situations.',
  pitfall_en = 'Utility folders tend to grow unchecked. Split them into files grouped by related functionality.'
WHERE term = 'Utility' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Converting a string into structured data',
  definition_en = 'Analyzing a string and converting it into a format a program can work with easily—objects, numbers, etc.',
  mechanism_en = 'JSON.parse(jsonString) converts a JSON string to an object. parseInt(''42'') converts a string to a number.',
  analogy_en = 'Translation. Converting a foreign language (raw string) into your native language (structured data) so you can understand it.',
  pitfall_en = 'Parsing invalid JSON throws an error. Always wrap parse calls in try/catch.'
WHERE term = 'Parsing' AND chapter_id = 7;
