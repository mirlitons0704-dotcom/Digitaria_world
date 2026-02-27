/*
  # Seed English translations for Chapter 7 terms (part 1 of 2)

  Translates the first 20 terms of Chapter 7.
  Topics: JavaScript, TypeScript, ES6, async/await, promises,
  modules, imports/exports.
*/

UPDATE terms SET
  one_liner_en = 'The programming language that brings web pages to life',
  definition_en = 'A programming language that runs in web browsers. It adds interactivity and dynamic functionality to pages. Now also used on the server side via Node.js.',
  mechanism_en = 'Executed by a JavaScript engine built into the browser. Provides a wide range of capabilities: DOM manipulation, event handling, asynchronous communication.',
  analogy_en = 'The electrical wiring in a house. HTML (structure) and CSS (decor) build the house, and JavaScript adds the mechanisms—flip a switch and the lights turn on.',
  pitfall_en = '"Java" and "JavaScript" are completely different languages! The names are similar, but their syntax and use cases are entirely separate.'
WHERE term = 'JavaScript' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'JavaScript enhanced with a type system for safer code',
  definition_en = 'A language that adds static typing to JavaScript. Developed by Microsoft. It catches errors at compile time, making it well-suited for large-scale development.',
  mechanism_en = 'TypeScript code is compiled (transpiled) into JavaScript. Type information is removed at runtime.',
  analogy_en = 'A form with labeled fields. "Enter a number here," "enter text there"—the predefined structure prevents mistakes.',
  pitfall_en = 'There is a learning curve, but in large projects TypeScript catches bugs early, ultimately saving time.'
WHERE term = 'TypeScript' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A major JavaScript update released in 2015',
  definition_en = 'The common name for ECMAScript 2015. A pivotal version that introduced many new features: let/const, arrow functions, classes, modules, and more.',
  mechanism_en = 'The JavaScript standard is defined by ECMAScript. Since ES6, new features have been added annually.',
  analogy_en = 'A major OS update. Like a smartphone getting a big upgrade that unlocks many useful new features.',
  pitfall_en = 'Older browsers may not support ES6 features. Tools like Babel can transpile code for backward compatibility.'
WHERE term = 'ES6' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'The official specification behind JavaScript',
  definition_en = 'The standard specification that defines the JavaScript language, maintained by ECMA International. ES6, ES2020, etc. are its version names.',
  mechanism_en = 'Browser vendors (Google, Mozilla, Apple, etc.) implement their JavaScript engines according to this specification.',
  analogy_en = 'A rule book. "JavaScript should behave this way" is the specification, and each browser follows it.',
  pitfall_en = 'ECMAScript and JavaScript are nearly synonymous, but strictly speaking, ECMAScript is the spec and JavaScript is its implementation.'
WHERE term = 'ECMAScript' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A keyword for declaring reassignable variables',
  definition_en = 'A keyword that declares a variable with block scope. Its value can be changed later. Introduced in ES6.',
  mechanism_en = 'let x = 10; declares the variable, and x = 20; reassigns it. Valid only within the enclosing { } block.',
  analogy_en = 'A whiteboard you can erase and rewrite. Change the content whenever you need to.',
  pitfall_en = 'Avoid var; use let instead. var has function scope, which often leads to unintended behavior.'
WHERE term = 'Let' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A keyword for declaring constants that cannot be reassigned',
  definition_en = 'A keyword that declares a variable whose value cannot be reassigned. Has block scope. Introduced in ES6.',
  mechanism_en = 'const PI = 3.14; locks the value. Attempting PI = 3; afterward throws an error.',
  analogy_en = 'An inscription carved in stone. Once engraved, it cannot be changed. Use it for values that should stay fixed.',
  pitfall_en = 'A const object or array can still have its contents modified—only reassignment of the variable itself is blocked.'
WHERE term = 'Const' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A concise function syntax using =>',
  definition_en = 'A shorthand function syntax introduced in ES6 using the => symbol. Behaves differently from regular functions regarding "this."',
  mechanism_en = 'Written as const add = (a, b) => a + b;. If there is only one parameter, the parentheses can be omitted.',
  analogy_en = 'Shorthand notation. The same meaning written more compactly.',
  pitfall_en = 'Arrow functions do not have their own "this." Be careful when using "this" inside event handlers.'
WHERE term = 'Arrow function' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A keyword that marks a function as asynchronous',
  definition_en = 'Placed before a function to indicate it performs asynchronous operations. The function always returns a Promise.',
  mechanism_en = 'async function fetchData() { ... } — inside, you can use await to pause until an async operation completes.',
  analogy_en = 'A "please wait" sign. It announces upfront that the operation will take some time.',
  pitfall_en = 'An async function always returns a Promise, even if it looks like it returns a plain value.'
WHERE term = 'Async' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A keyword that waits for a Promise to resolve',
  definition_en = 'Used inside an async function to pause execution until a Promise settles. Lets you write asynchronous code that reads like synchronous code.',
  mechanism_en = 'const data = await fetch(url); pauses until fetch completes. Errors can be caught with try/catch.',
  analogy_en = 'Saying "wait." Just as you wait for your food to arrive, await waits for data to come back.',
  pitfall_en = 'await can only be used inside an async function. Using it at the top level requires special handling.'
WHERE term = 'Await' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'An object representing a future result',
  definition_en = 'An object that represents the eventual result of an asynchronous operation. Has three states: pending, fulfilled (success), and rejected (failure).',
  mechanism_en = 'Created with new Promise((resolve, reject) => { ... }). Call resolve on success, reject on failure.',
  analogy_en = 'A claim ticket. "We''ll deliver your item later." When it arrives (fulfilled), you pick it up; if it doesn''t (rejected), you file a complaint.',
  pitfall_en = 'Deeply chained Promises become hard to read. async/await makes the flow much clearer.'
WHERE term = 'Promise' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'An API for making HTTP requests',
  definition_en = 'A web API for sending HTTP requests and retrieving data. Returns a Promise and operates asynchronously.',
  mechanism_en = 'fetch(url).then(res => res.json()).then(data => ...) or use with async/await.',
  analogy_en = 'Ordering delivery. You place the call (fetch), then wait for the food (data) to arrive.',
  pitfall_en = 'fetch does not reject on HTTP errors (404, 500). You must check response.ok yourself.'
WHERE term = 'Fetch' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Methods for handling Promise success and failure',
  definition_en = 'Methods that process the outcome of a Promise. then() handles success; catch() handles failure.',
  mechanism_en = 'promise.then(result => {...}).catch(error => {...}) — chained in sequence.',
  analogy_en = 'A pre-planned contingency: "If it works, do this; if it fails, do that."',
  pitfall_en = 'Omitting catch() silently swallows errors. Always include error handling.'
WHERE term = 'Then/catch' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'The "..." syntax that expands arrays or objects',
  definition_en = 'An operator using ... to spread the elements of an array or object. Useful for copying and merging.',
  mechanism_en = '[...arr1, ...arr2] merges arrays; {...obj, newProp: value} adds a property to an object copy.',
  analogy_en = 'Fanning out a deck of cards on a table. Bundled items are laid out individually.',
  pitfall_en = 'Spread creates a shallow copy. Nested objects are still shared by reference.'
WHERE term = 'Spread operator' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Syntax for extracting values from arrays or objects',
  definition_en = 'A concise syntax for unpacking values from arrays or objects into individual variables. Introduced in ES6.',
  mechanism_en = 'const [a, b] = [1, 2]; or const {name, age} = person;',
  analogy_en = 'Opening a gift box and placing each item in its own spot. Multiple values extracted at once.',
  pitfall_en = 'Destructuring a nonexistent property yields undefined. You can set default values to handle this.'
WHERE term = 'Destructuring' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'A way to split code into separate files',
  definition_en = 'A system for dividing code across multiple files and loading only the parts you need. Improves reusability and maintainability.',
  mechanism_en = 'Use export to make code available and import to load it. ES6 modules work in both browsers and Node.js.',
  analogy_en = 'LEGO parts. Grab only the pieces you need and snap them together—no need to use everything at once.',
  pitfall_en = 'Watch out for circular imports (A imports B, B imports A). This usually signals a design issue.'
WHERE term = 'Module' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Loading functionality from another module',
  definition_en = 'A keyword for loading exported functions, variables, or classes from another file.',
  mechanism_en = 'import { func } from ''./module.js''; or import func from ''./module.js'';',
  analogy_en = 'Borrowing a book from the library. You check out the resource (function) you need for your work.',
  pitfall_en = 'The import syntax differs between named exports and default exports.'
WHERE term = 'Import' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Making functionality available to other modules',
  definition_en = 'A keyword for exposing functions, variables, or classes from a module so other files can import them.',
  mechanism_en = 'export const func = () => {}; or export { func, variable };',
  analogy_en = 'Putting products on display in a shop. Others (modules) can browse and buy (import) what they need.',
  pitfall_en = 'Don''t export everything. Only expose what other modules actually need—practice encapsulation.'
WHERE term = 'Export' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'The primary export of a module',
  definition_en = 'A single "main" export per module. When imported, it can be given any name the importer chooses.',
  mechanism_en = 'export default function() {}; to export; import anyName from ''./module''; to import.',
  analogy_en = 'A shop''s signature product. There may be other items, but this is the flagship.',
  pitfall_en = 'Only one default export is allowed per module. It can be used alongside named exports.'
WHERE term = 'Default export' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Exporting by a specific name',
  definition_en = 'A way to export functions or variables by name. The importer must use the same name to receive them.',
  mechanism_en = 'export { func, variable }; to export; import { func, variable } from ''./module''; to import.',
  analogy_en = 'Selling products with name tags. You request the exact product by its label.',
  pitfall_en = 'A wrong name in the import causes an error. Use "as" to rename if needed.'
WHERE term = 'Named export' AND chapter_id = 7;

UPDATE terms SET
  one_liner_en = 'Re-exporting multiple modules from a single file',
  definition_en = 'A pattern where one index file re-exports from multiple modules, consolidating imports for consumers.',
  mechanism_en = 'In index.js: export { a } from ''./a''; export { b } from ''./b''; — external code imports from one place.',
  analogy_en = 'A reception desk. All departments (modules) are accessible through one central point, making things easier for visitors.',
  pitfall_en = 'Overly large barrel files can interfere with tree-shaking (dead code elimination).'
WHERE term = 'Barrel exports' AND chapter_id = 7;
