/*
  # Seed English translations for Chapter 4 terms (part 1 of 2)

  Translates the first 21 terms of Chapter 4.
  Topics: syntax fundamentals, functions, scope, loops, conditionals.
*/

UPDATE terms SET
  one_liner_en = 'The grammar rules of a programming language',
  definition_en = 'The rules that govern how code must be written in a programming language—what order words go in, what symbols to use, and how to structure instructions.',
  mechanism_en = 'Code that violates syntax rules triggers a syntax error and cannot run. Each programming language has its own syntax.',
  analogy_en = 'Grammar in a spoken language. Japanese follows "subject-object-verb" order; English follows "subject-verb-object." Programming languages have their own word-order rules.',
  pitfall_en = 'A missing semicolon or an unclosed bracket can cause errors. Read the error message carefully—it usually points to the exact location.'
WHERE term = 'Syntax' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A single unit of executable instruction',
  definition_en = 'One unit of instruction in a program. Variable declarations, assignments, conditionals, and loops are all statements.',
  mechanism_en = 'Delimited by semicolons or curly braces, like let x = 10; or if (condition) { ... }. Executed from top to bottom.',
  analogy_en = 'A sentence in language. "I run." "He eats." Each one is a complete, meaningful unit of instruction.',
  pitfall_en = 'The difference between an expression and a statement can be confusing. An expression produces a value; a statement performs an action.'
WHERE term = 'Statement' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A piece of code that produces a value',
  definition_en = 'A fragment of code that, when evaluated, returns a value. Arithmetic formulas, function calls, and variable references are all expressions.',
  mechanism_en = '5 + 3 is an expression that returns 8. x > 10 is an expression that returns true or false. Expressions are often used as parts of statements.',
  analogy_en = 'A math equation. "2 + 3" evaluates to the answer "5."',
  pitfall_en = 'x = 5 is an assignment statement, but the 5 on the right side is an expression. Statements and expressions often intermingle.'
WHERE term = 'Expression' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A symbol that performs a calculation or comparison',
  definition_en = 'A symbol that performs an operation on values. Includes arithmetic operators (+, -, *, /), comparison operators (===, <, >), and logical operators (&&, ||).',
  mechanism_en = 'In a + b, the + is the operator and a and b are the operands. Operators have precedence rules—* is evaluated before +.',
  analogy_en = 'The +, -, x, and / buttons on a calculator. They act on the numbers (operands) you enter.',
  pitfall_en = 'Watch out for =, ==, and ===. = is assignment, == is loose equality, === is strict equality. In JavaScript, always prefer ===.'
WHERE term = 'Operator' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Storing a value in a variable',
  definition_en = 'The operation of placing a value into a variable. Uses the = symbol to put the right-hand value into the left-hand variable.',
  mechanism_en = 'let x = 10; assigns 10 to x. x = x + 1; adds 1 to x''s current value and reassigns the result.',
  analogy_en = 'Labeling a box and putting something inside. You label a box "apples" and place an apple in it.',
  pitfall_en = 'The = in programming is not the same as in math. In a program, = means "store this value," not "is equal to."'
WHERE term = 'Assignment' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Creating a new variable or function',
  definition_en = 'Defining a new variable or function. Keywords like let, const, and function announce: "I''m going to use this."',
  mechanism_en = 'let x; declares a variable named x. function greet() {} declares a function named greet. They become usable after declaration.',
  analogy_en = 'Introducing a new employee. "Starting today, Yamada joins the team." Only after the introduction can they get to work.',
  pitfall_en = 'Declaration and assignment are separate. let x; is declaration only; let x = 10; is declaration plus assignment in one step.'
WHERE term = 'Declaration' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A reusable block of code with a name',
  definition_en = 'A named bundle of instructions that can be called as many times as needed. It can accept inputs (parameters) and return an output (return value).',
  mechanism_en = 'Defined as function name(params) { ... return result; }. Called with name(). Promotes code reuse.',
  analogy_en = 'A cooking recipe. Save the "how to make curry" recipe (function) once, and you can follow the same steps anytime.',
  pitfall_en = 'Functions can call other functions—or even themselves (recursion). Just be careful to avoid infinite loops.'
WHERE term = 'Function' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A function that belongs to an object',
  definition_en = 'A function defined as a property of an object. Called with the syntax object.methodName().',
  mechanism_en = 'const obj = { greet: function() { return "Hello"; } }; is called with obj.greet(). Array''s push() and string''s toUpperCase() are also methods.',
  analogy_en = 'Skills a person possesses. "alice.cook()" and "alice.run()"—actions that belong to that specific object (person).',
  pitfall_en = 'Functions and methods are similar, but methods are always attached to an object. The behavior of "this" also differs between the two.'
WHERE term = 'Method' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A placeholder for a value a function will receive',
  definition_en = 'A variable specified in a function''s definition that receives a value when the function is called. Also known as a "formal parameter."',
  mechanism_en = 'In function greet(name) { ... }, name is the parameter. Inside the function, the passed value is accessible by that name.',
  analogy_en = 'A blank field on an order form. "Name: ___" is the parameter (blank); the actual name filled in is the argument.',
  pitfall_en = '"Parameter" and "argument" are often confused. A parameter is on the definition side; an argument is on the calling side.'
WHERE term = 'Parameter' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'Multiple placeholders a function receives',
  definition_en = 'When a function accepts multiple values, each placeholder is a parameter. They are separated by commas in the definition.',
  mechanism_en = 'In function add(a, b) { return a + b; }, a and b are both parameters. Arguments are matched to them in order.',
  analogy_en = 'Multiple blanks on an order form: "Name: ___", "Address: ___", "Phone: ___"—each field accepts its own value.',
  pitfall_en = 'If the number of arguments doesn''t match the number of parameters, you may get errors or undefined values.'
WHERE term = 'Parameters' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The actual value passed to a function',
  definition_en = 'The concrete value supplied when calling a function. Also known as an "actual parameter." Matched to the corresponding parameter.',
  mechanism_en = 'In greet("Alice"), the string "Alice" is the argument. Inside the function, it''s accessible via the corresponding parameter name.',
  analogy_en = 'The actual information you write in a form''s blank field. The blank (parameter) says "Name"; you write "Alice" (argument).',
  pitfall_en = 'Passing arguments in the wrong order leads to unexpected behavior. Some languages support keyword arguments to avoid this.'
WHERE term = 'Argument' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The result a function sends back',
  definition_en = 'The value a function produces and passes back to the caller. Specified with the return statement.',
  mechanism_en = 'function add(a, b) { return a + b; } — calling add(2, 3) returns 5. Without a return statement, the function returns undefined.',
  analogy_en = 'A vending machine''s output. You insert money (arguments), and a product (return value) comes out.',
  pitfall_en = 'Forgetting the return statement causes the function to return undefined. Also, any code after return is never executed.'
WHERE term = 'Return value' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The region where a variable is accessible',
  definition_en = 'The range within which a variable can be referenced. Variables cannot be accessed from outside their scope.',
  mechanism_en = 'A variable''s scope is determined by where it is declared. A variable inside a function is invisible outside that function.',
  analogy_en = 'A classroom. The teacher''s voice (variable) can only be heard inside the room (scope)—it doesn''t carry to the next room.',
  pitfall_en = 'Variables with the same name can exist in different scopes. Always be aware of which one you''re referencing.'
WHERE term = 'Scope' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The area inside a function only',
  definition_en = 'The scope within which a variable declared inside a function is valid. It can only be accessed from within that function.',
  mechanism_en = 'In function test() { let local = 1; }, the variable local is usable only inside test. Referencing it outside causes an error.',
  analogy_en = 'A bookshelf in your room. Books (variables) in your room (function) can''t be grabbed from outside.',
  pitfall_en = 'Local variables vanish when the function finishes. To preserve them, use a closure.'
WHERE term = 'Local scope' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The outermost area visible to the entire program',
  definition_en = 'The outermost scope, accessible from anywhere in the program. Variables declared at this level become global variables.',
  mechanism_en = 'Variables declared outside any function are global. Convenient, but carry the risk of unintended modification.',
  analogy_en = 'A school-wide announcement over the PA system. Every classroom (scope) can hear it. Handy, but you can''t say anything private.',
  pitfall_en = 'Avoid overusing global variables. Because anything can modify them, they are a common source of hard-to-find bugs.'
WHERE term = 'Global scope' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The area inside a pair of { } braces',
  definition_en = 'A scope that is valid only within a block delimited by curly braces { }. Variables declared with let and const have block scope.',
  mechanism_en = 'In if (true) { let x = 1; }, x cannot be accessed outside the braces. var does not respect block scope.',
  analogy_en = 'A meeting room. What''s said inside the room (block) doesn''t leak out once you leave.',
  pitfall_en = 'var ignores block scope, which can cause unexpected behavior. Stick to let and const as a rule.'
WHERE term = 'Block scope' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A function that remembers its surrounding variables',
  definition_en = 'A mechanism by which a function "remembers" the variables from the scope in which it was defined, even after that scope has exited.',
  mechanism_en = 'If an inner function references a variable from an outer function, that variable is retained even after the outer function returns.',
  analogy_en = 'A photograph of a memory. Even after leaving a place (scope), looking at the photo (closure) recalls the state from that moment.',
  pitfall_en = 'Heavy use of closures can increase memory consumption. Unintended variable retention can also lead to subtle bugs.'
WHERE term = 'Closure' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A structure that repeats the same operation',
  definition_en = 'A control structure that executes the same block of code repeatedly as long as a condition is met. Includes for, while, and do-while loops.',
  mechanism_en = 'for (let i = 0; i < 5; i++) { ... } repeats 5 times. The loop continues until the condition evaluates to false.',
  analogy_en = 'Running laps on a track. You keep circling until you reach the finish line (the condition becomes false).',
  pitfall_en = 'A wrong condition can create an infinite loop. Always verify that the exit condition will eventually be met.'
WHERE term = 'Loop' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'One pass through a loop',
  definition_en = 'A single cycle of a loop. If a loop runs 5 times, it has 5 iterations.',
  mechanism_en = 'Each time a for loop completes one cycle, that is one iteration. Processing each element of an array is also one iteration per element.',
  analogy_en = 'One lap around the track. Running 10 laps means 10 iterations.',
  pitfall_en = 'Getting the iteration count wrong means processing too many or too few items.'
WHERE term = 'Iteration' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'A structure that branches based on a condition',
  definition_en = 'A control structure that executes different code paths depending on whether a condition is true or false. Includes if statements and switch statements.',
  mechanism_en = 'if (condition) { true path } else { false path } — different code runs depending on the condition.',
  analogy_en = 'A fork in the road. "If it''s raining, take an umbrella; if it''s sunny, wear sunglasses"—your action depends on the situation.',
  pitfall_en = 'The order of conditions matters. More specific conditions should come first, since earlier matches take priority.'
WHERE term = 'Conditional' AND chapter_id = 4;

UPDATE terms SET
  one_liner_en = 'The "if this, otherwise that" construct',
  definition_en = 'The most fundamental conditional construct: if the condition is true, execute the if block; otherwise, execute the else block.',
  mechanism_en = 'if (score >= 80) { "Pass" } else { "Fail" }. You can chain multiple conditions with else if.',
  analogy_en = 'A true-or-false quiz. "Correct? Show a check mark. Wrong? Show an X." The display changes based on the result.',
  pitfall_en = 'Omitting the else means nothing happens when the condition is false. Add else when a fallback action is needed.'
WHERE term = 'If/else' AND chapter_id = 4;
