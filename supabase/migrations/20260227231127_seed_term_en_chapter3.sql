/*
  # Seed English translations for Chapter 3 terms

  Translates all 5 English fields for the 30 terms in Chapter 3.
  Topics: data types (String, Boolean, Integer, Number, Null, Undefined,
  Primitive, Data type, Tuple, Enum, Union type, Type alias, Interface),
  data structures (Array, Object, Key-value pair, Variable, Constant,
  Set, Map, Hash, Index, Schema, Record, Field, Stack, Queue, Tree,
  Graph, Vector).
*/

UPDATE terms SET
  one_liner_en = 'A sequence of characters—text data',
  definition_en = 'A data type representing a chain of characters. Written inside quotation marks, like "Hello" or "world."',
  mechanism_en = 'Internally stored as an array of numeric character codes (ASCII or UTF-8). Supports operations such as concatenation, splitting, and searching.',
  analogy_en = 'A beaded necklace. Each bead (character) is strung together on a thread (the string).',
  pitfall_en = 'Numbers can also be strings. "123" is a string, while 123 is a number. To do math, you need to convert the string to a numeric type first.'
WHERE term = 'String' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A value that is either true or false',
  definition_en = 'A data type that holds only two possible values: true or false. Used to represent the result of a condition.',
  mechanism_en = 'The result of a conditional expression is always a Boolean. For example: 5 > 3 evaluates to true; 5 < 3 evaluates to false. Used in the condition part of if statements.',
  analogy_en = 'A yes-or-no question, or a light switch that is either ON or OFF. The answer can only be one of two things.',
  pitfall_en = '"true" (a string) and true (a Boolean) are different things. Mixing them up is a common source of bugs.'
WHERE term = 'Boolean' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A whole number with no decimal point',
  definition_en = 'A numeric data type with no fractional part: ..., -2, -1, 0, 1, 2, ...',
  mechanism_en = 'Some languages strictly distinguish between integers and floating-point numbers. In JavaScript, both fall under the unified Number type.',
  analogy_en = 'Counting apples. You say 1, 2, or 3—never 1.5 apples.',
  pitfall_en = 'In JavaScript, integers and decimals are both "Number." However, languages like TypeScript, Java, and Python do make the distinction.'
WHERE term = 'Integer' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'Numeric data you can do math with',
  definition_en = 'A data type representing numeric values—integers, decimals, and negative numbers. Supports arithmetic and comparison operations.',
  mechanism_en = 'Internally represented in binary. Decimals are stored in floating-point format, which can introduce tiny rounding errors.',
  analogy_en = 'The numbers you punch into a calculator. You can add, subtract, multiply, and divide them.',
  pitfall_en = '0.1 + 0.2 === 0.3 can evaluate to false due to floating-point precision errors. Be especially careful with financial calculations.'
WHERE term = 'Number' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A value that intentionally means "nothing"',
  definition_en = 'A special value indicating that no value exists on purpose. Used when you want to explicitly set a variable to "empty."',
  mechanism_en = 'null is a deliberate "empty" set by the developer. It differs from undefined, which means "not yet assigned." null says, "I intentionally left this empty."',
  analogy_en = 'An empty lunchbox. The box (variable) is ready, but you deliberately chose not to put anything inside.',
  pitfall_en = 'The difference between null and undefined trips up many beginners. null means "intentionally empty"; undefined means "nothing has been set yet."'
WHERE term = 'Null' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A value meaning "not yet defined"',
  definition_en = 'The value of a variable that has been declared but not assigned, or of a property that does not exist on an object.',
  mechanism_en = 'If you write let x; without assigning a value, x becomes undefined.',
  analogy_en = 'A package that hasn''t arrived yet. It''s expected to come, but right now it simply doesn''t exist.',
  pitfall_en = 'null is an explicit empty; undefined is an implicit absence. Both are falsy, but they are not strictly equal (=== returns false).'
WHERE term = 'Undefined' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'An ordered list of data',
  definition_en = 'A data structure that stores multiple values in a specific order. Each element can be accessed by its index (position number).',
  mechanism_en = 'Written with square brackets and comma-separated values: [1, 2, 3] or ["apple", "orange", "grape"]. Indexes start at 0.',
  analogy_en = 'A row of numbered lockers. You retrieve items by their locker number: 0, 1, 2, and so on.',
  pitfall_en = 'Indexes start at 0, not 1. In an array with 3 elements, the last element has index 2, not 3.'
WHERE term = 'Array' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A collection of named key-value pairs',
  definition_en = 'A data structure that holds multiple key-value pairs, where each key (name) maps to a value. Useful for grouping related data together.',
  mechanism_en = 'Written with curly braces: { name: "Alice", age: 25 }. Keys and values are separated by colons.',
  analogy_en = 'A contact card. It bundles labeled information—"name," "phone," "address"—so you can carry it all in one place.',
  pitfall_en = 'Arrays and objects are easy to mix up. Use arrays when order matters; use objects when you want to look up data by name.'
WHERE term = 'Object' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A name paired with its data',
  definition_en = 'A combination of a key (an identifier or name) and the value it maps to. The fundamental building block of objects and maps.',
  mechanism_en = 'In name: "Alice", "name" is the key and "Alice" is the value. Keys must be unique within a given object.',
  analogy_en = 'A dictionary entry: "apple (headword): a round fruit (definition)." The headword is the key, the definition is the value.',
  pitfall_en = 'In JavaScript, keys are always strings (or Symbols). Even if you use a number as a key, it gets converted to a string internally.'
WHERE term = 'Key-value pair' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A named container that holds data',
  definition_en = 'A mechanism for storing a value and accessing it by name. The value can be changed while the program is running.',
  mechanism_en = 'let x = 10; stores 10 in a variable called x. Later, x = 20; changes its value.',
  analogy_en = 'A labeled box. If a box is labeled "apples," you know what''s inside just by reading the label.',
  pitfall_en = 'Give variables meaningful names. userName or totalPrice is far more readable than x or temp.'
WHERE term = 'Variable' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A container whose value cannot be changed',
  definition_en = 'A variable that, once assigned, cannot be reassigned. Declared with the const keyword.',
  mechanism_en = 'const PI = 3.14159; locks the value. Attempting PI = 3; afterward throws an error.',
  analogy_en = 'An inscription carved in stone. Once engraved, it cannot be erased.',
  pitfall_en = 'A const object or array can still have its contents modified—only reassignment of the variable itself is blocked.'
WHERE term = 'Constant' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'The category or kind of a piece of data',
  definition_en = 'A classification that describes a value''s nature. Strings, numbers, booleans, arrays, and objects are all different data types, each with its own set of operations.',
  mechanism_en = 'The available operations depend on the type. Strings can be concatenated, numbers can be calculated, arrays can be iterated.',
  analogy_en = 'Categories of ingredients. Vegetables, meat, fish—each category requires different cooking techniques.',
  pitfall_en = 'JavaScript is a loosely typed language, but that makes type awareness even more important to avoid subtle bugs.'
WHERE term = 'Data type' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'The most basic, indivisible data types',
  definition_en = 'Fundamental data types that cannot be broken down further. In JavaScript there are 7: string, number, boolean, null, undefined, symbol, and bigint.',
  mechanism_en = 'Primitive values are copied by value, not by reference.',
  analogy_en = 'Chemical elements. Hydrogen, oxygen—the basic building blocks that cannot be decomposed further.',
  pitfall_en = 'Primitives are immutable. Writing "hello"[0] = "H" does not change the original string.'
WHERE term = 'Primitive' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A fixed-length array where position carries meaning',
  definition_en = 'An array with a fixed number of elements, each with a predetermined type. Used when the position of each element is significant.',
  mechanism_en = 'Example: const point: [number, number] = [10, 20]; represents an x-y coordinate pair.',
  analogy_en = 'Coordinates (x, y) or RGB values (red, green, blue)—ordered sets where each position has a specific meaning.',
  pitfall_en = 'JavaScript has no built-in tuple type; they are treated as regular arrays. TypeScript can enforce tuple types at compile time.'
WHERE term = 'Tuple' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A collection of unique values with no duplicates',
  definition_en = 'A collection that cannot contain duplicate values. Checking whether a value exists is very fast.',
  mechanism_en = 'new Set([1, 2, 2, 3]) produces {1, 2, 3}—the duplicate is automatically removed.',
  analogy_en = 'An attendance roster. Even if the same person checks in twice, their name appears only once.',
  pitfall_en = 'Unlike arrays, you cannot access Set elements by index.'
WHERE term = 'Set' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'An efficient key-value store',
  definition_en = 'A key-value data structure that accepts any type as a key. More flexible and often faster than plain objects.',
  mechanism_en = 'Created with new Map(). Use set(key, value) to add entries and get(key) to retrieve them.',
  analogy_en = 'A phone book. Look up a name (key) and you get a phone number (value).',
  pitfall_en = 'Deciding when to use a Map versus a plain object can be confusing. Maps are generally better for dynamic key sets and non-string keys.'
WHERE term = 'Map' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A mechanism for fast key-based lookups',
  definition_en = 'A data structure that converts a key into a numeric hash value and uses it to store and retrieve values extremely quickly.',
  mechanism_en = 'A hash function transforms the key into a number, which is then used as an array index.',
  analogy_en = 'A library shelf system. A formula derived from a book''s title determines exactly which shelf it belongs on.',
  pitfall_en = '"Hash" can refer to either a cryptographic hash or a hash-based data structure. The meaning depends on context.'
WHERE term = 'Hash' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'The position number of an element in an array',
  definition_en = 'A sequential number assigned to each element in an array. In most programming languages, indexing starts at 0.',
  mechanism_en = 'arr[0] accesses the first element; arr[1] accesses the second.',
  analogy_en = 'Apartment room numbers—except numbering starts at room 0.',
  pitfall_en = 'The "third element" has index 2. The mismatch between human counting (from 1) and programming counting (from 0) is a classic stumbling block.'
WHERE term = 'Index' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A blueprint defining a data structure',
  definition_en = 'A specification that describes what structure data should have.',
  mechanism_en = 'For example: "a user has a name (string) and an age (number)." The schema pre-defines the shape of the data.',
  analogy_en = 'A pre-printed form. The fields and their expected types are already laid out for you.',
  pitfall_en = 'A schema that is too strict reduces flexibility; one that is too loose degrades data quality. Finding the right balance is key.'
WHERE term = 'Schema' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A single entry of grouped data',
  definition_en = 'One row in a database table, or a unit of data comprising a set of related fields.',
  mechanism_en = 'Each row in a users table is one record.',
  analogy_en = 'One line in a roster: "ID, Name, Address, Phone Number"—all the information for a single person.',
  pitfall_en = 'TypeScript''s Record<K, V> type is a different concept from a database record—don''t confuse the two.'
WHERE term = 'Record' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A single item within a record',
  definition_en = 'An individual attribute or property inside an object or database record.',
  mechanism_en = 'In a user record, "name," "age," and "email" are each separate fields.',
  analogy_en = 'An input box on a form—"Name field," "Age field," and so on.',
  pitfall_en = 'The same concept goes by different names depending on context: property, attribute, member variable, column.'
WHERE term = 'Field' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A type that restricts values to a fixed set of options',
  definition_en = 'An enumeration type. A data type where the value must be one of a predefined set of named constants.',
  mechanism_en = 'enum Color { Red, Green, Blue } defines the options. You reference them as Color.Red, etc.',
  analogy_en = 'A dropdown menu. The available choices are predetermined.',
  pitfall_en = 'TypeScript enums can get surprisingly complex. For simple cases, a union type may be easier to work with.'
WHERE term = 'Enum' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A type that defines the shape of an object',
  definition_en = 'Defines what properties and methods an object must have.',
  mechanism_en = 'interface User { name: string; age: number; } declares the required shape.',
  analogy_en = 'A contract. It guarantees: "any object of this type will have these properties."',
  pitfall_en = 'Choosing between interface and type can be confusing. Both are similar, but interfaces are better suited for object shapes that may be extended.'
WHERE term = 'Interface' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A custom name assigned to a type',
  definition_en = 'A feature that lets you give a name to a complex or frequently used type so it can be reused easily.',
  mechanism_en = 'type UserId = string; assigns a name to a type for convenient reuse.',
  analogy_en = 'A nickname. A short, convenient alias for a longer type name.',
  pitfall_en = 'Type aliases can do almost everything interfaces can, but for union types a type alias is the better choice.'
WHERE term = 'Type alias' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A type that accepts one of several possible types',
  definition_en = 'A type that means "either A or B (or C, ...)," allowing a value to be any one of the listed types.',
  mechanism_en = 'type Status = "success" | "error" | "loading"; restricts the value to one of those three strings.',
  analogy_en = 'A payment method that accepts "cash or card." Either option is valid.',
  pitfall_en = 'When using union types, you may need a type guard to narrow down which specific type a value actually is.'
WHERE term = 'Union type' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A last-in, first-out (LIFO) data structure',
  definition_en = 'A data structure where the most recently added element is the first one removed. Last In, First Out.',
  mechanism_en = 'push() adds an element to the top; pop() removes it from the top.',
  analogy_en = 'A stack of books. The book you placed on top last is the first one you pick up.',
  pitfall_en = 'You can implement a stack with a regular array, but discipline yourself to use only push() and pop().'
WHERE term = 'Stack' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A first-in, first-out (FIFO) data structure',
  definition_en = 'A data structure where the first element added is the first one removed. First In, First Out.',
  mechanism_en = 'enqueue adds to the back; dequeue removes from the front.',
  analogy_en = 'A checkout line at a store. The person who lined up first gets served first.',
  pitfall_en = 'In JavaScript, using shift() with push() simulates a queue, but shift() is slow on large arrays because it reindexes every element.'
WHERE term = 'Queue' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A hierarchical structure with parent-child relationships',
  definition_en = 'A data structure where nodes are connected in parent-child relationships forming a hierarchy.',
  mechanism_en = 'The topmost node is the "root"; nodes with no children are "leaves."',
  analogy_en = 'A family tree. Grandparents branch into parents, then children, then grandchildren.',
  pitfall_en = 'Recursive functions are commonly used for traversing tree structures.'
WHERE term = 'Tree' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A structure of nodes connected by edges',
  definition_en = 'A data structure made up of nodes (vertices) and edges that connect them.',
  mechanism_en = 'Unlike trees, graphs can contain cycles (loops).',
  analogy_en = 'A subway map. Stations (nodes) are connected by rail lines (edges).',
  pitfall_en = 'Graph traversal algorithms (BFS, DFS, etc.) can be challenging to learn but are fundamental in computer science.'
WHERE term = 'Graph' AND chapter_id = 3;

UPDATE terms SET
  one_liner_en = 'A quantity with both direction and magnitude',
  definition_en = 'Mathematically, a quantity with direction and magnitude. In programming, typically represented as an array of numbers.',
  mechanism_en = 'Represented as a numeric array like [3, 4]. Supports operations such as addition, subtraction, and scalar multiplication.',
  analogy_en = 'An arrow on a map. It shows both which direction to go and how far.',
  pitfall_en = 'In some languages, "Vector" refers to a resizable array rather than the mathematical concept.'
WHERE term = 'Vector' AND chapter_id = 3;
