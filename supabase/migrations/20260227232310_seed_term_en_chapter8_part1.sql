/*
  # Seed English translations for Chapter 8 terms (part 1 of 2)

  Translates the first 20 terms of Chapter 8.
  Topics: React core, components, JSX, hooks, lifecycle.
*/

UPDATE terms SET
  one_liner_en = 'A JavaScript library for building UIs from components',
  definition_en = 'A JavaScript library for building user interfaces, developed by Facebook (now Meta). Uses a component-based architecture to create interactive UIs efficiently.',
  mechanism_en = 'Uses a virtual DOM for efficient screen updates. When state changes, only the parts that need updating are re-rendered.',
  analogy_en = 'LEGO bricks. You snap small blocks (components) together to build a large creation (an app).',
  pitfall_en = 'React is a library, not a framework. Routing and state management require additional libraries.'
WHERE term = 'React' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A reusable building block of a UI',
  definition_en = 'The smallest unit of UI in React. Each component has its own logic and appearance and can be reused. Buttons, cards, forms—all are components.',
  mechanism_en = 'Defined as a function (or class) that returns JSX. Components can be composed together.',
  analogy_en = 'LEGO pieces. A wheel, a window, a door—each part has a role, and you combine them to build a house or car.',
  pitfall_en = 'Component names must start with a capital letter. Lowercase names are interpreted as HTML tags.'
WHERE term = 'React component' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A component defined as a function',
  definition_en = 'A React component written as a JavaScript function. Since the introduction of Hooks, this has become the standard approach.',
  mechanism_en = 'function MyComponent(props) { return <div>...</div>; } — can also be written as an arrow function.',
  analogy_en = 'A recipe. It takes ingredients (props) and produces a dish (JSX).',
  pitfall_en = 'Simpler than class components, but lifecycle behavior must be implemented via Hooks.'
WHERE term = 'Functional component' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A syntax that lets you write HTML inside JavaScript',
  definition_en = 'Stands for JavaScript XML. An extension syntax that lets you write HTML-like markup directly in JavaScript. Used to describe UI in React.',
  mechanism_en = 'const element = <h1>Hello</h1>; — Babel transforms this into standard JavaScript.',
  analogy_en = 'A bento box. You can pack HTML "ingredients" inside a JavaScript "container."',
  pitfall_en = 'class is a reserved word, so use className. for becomes htmlFor. JSX has its own set of rules.'
WHERE term = 'JSX' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'TypeScript files that use JSX syntax',
  definition_en = 'The file extension (.tsx) for using JSX with TypeScript. Lets you write type-safe React components.',
  mechanism_en = 'Same JSX syntax, but with TypeScript''s type checking. You can define types for props and more.',
  analogy_en = 'A bento box with safety locks. The type system prevents the wrong ingredients (values) from being packed in.',
  pitfall_en = 'Rename .jsx files to .tsx and .js to .ts. Don''t mix extensions within a project.'
WHERE term = 'TSX' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Data passed from parent to child',
  definition_en = 'Short for "properties." Data that a parent component passes down to a child component. Read-only—the child cannot modify them.',
  mechanism_en = '<Child name="Alice" /> passes the prop; the child accesses it via props.name or destructuring { name }.',
  analogy_en = 'An order slip. The parent (waiter) hands the child (chef) instructions. The chef cannot change the order.',
  pitfall_en = 'Never mutate props directly (they are immutable). If you need changeable data, use State.'
WHERE term = 'Props' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Data within a component that can change over time',
  definition_en = 'Data owned by a component that can change. When state changes, the component re-renders to reflect the update.',
  mechanism_en = 'const [count, setCount] = useState(0); declares state. Calling setCount(1) triggers a re-render.',
  analogy_en = 'A notepad. You can write on it and erase it (change it). When you do, the display updates.',
  pitfall_en = 'Never modify state directly—always use the setter function. Direct mutation won''t trigger a re-render.'
WHERE term = 'State' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'The fundamental Hook for adding state',
  definition_en = 'A Hook that lets functional components use state. Returns a value and a function to update it.',
  mechanism_en = 'const [value, setValue] = useState(initialValue); — call setValue(newValue) to update.',
  analogy_en = 'A blackboard and eraser. Write on the board (state), erase it (setValue), and write something new.',
  pitfall_en = 'The updater function is asynchronous. Reading the value immediately after calling it may return the old value.'
WHERE term = 'useState' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A Hook for running side effects',
  definition_en = 'A Hook for executing side effects in a component—API calls, DOM manipulation, timer setup, and more.',
  mechanism_en = 'useEffect(() => { /* effect */ }, [dependencies]); — re-runs whenever a dependency changes.',
  analogy_en = 'A cleanup crew. "Once the painting (render) is done, take care of these tasks."',
  pitfall_en = 'An incorrect dependency array can cause infinite loops or stale data references.'
WHERE term = 'useEffect' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A Hook for reading Context values',
  definition_en = 'A Hook that retrieves the current value from a React Context. Avoids prop drilling by passing data to deeply nested components.',
  mechanism_en = 'const value = useContext(MyContext); retrieves the context''s current value. Must be wrapped in a Provider.',
  analogy_en = 'A PA announcement. Information reaches every floor (component) at once—no need to pass it down the stairs (props) one level at a time.',
  pitfall_en = 'When the context value changes, every component using it re-renders. Avoid overuse.'
WHERE term = 'useContext' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A Hook that holds a value without causing re-renders',
  definition_en = 'A Hook for persisting a value across renders without triggering a re-render. Used for DOM references and storing previous values.',
  mechanism_en = 'const ref = useRef(initialValue); — access the value via ref.current. Changes don''t trigger re-renders.',
  analogy_en = 'A sticky note on the wall. You can read and update it anytime, but it doesn''t trigger a room makeover (re-render).',
  pitfall_en = 'Since ref changes don''t cause re-renders, use state instead if the value should be reflected in the UI.'
WHERE term = 'useRef' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A Hook that caches expensive computation results',
  definition_en = 'A Hook that caches the result of a heavy computation and skips recalculation as long as the dependencies haven''t changed.',
  mechanism_en = 'const result = useMemo(() => expensiveCalc, [deps]); — returns the cached result if deps are unchanged.',
  analogy_en = 'Writing the answer on a note. If the same question comes up, just check the note instead of recalculating.',
  pitfall_en = 'Avoid premature optimization. Don''t use useMemo for simple calculations—use it only when you see performance issues.'
WHERE term = 'useMemo' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A Hook that caches a function reference',
  definition_en = 'A Hook that caches a function itself, returning the same reference as long as dependencies haven''t changed. Prevents unnecessary re-renders of child components.',
  mechanism_en = 'const fn = useCallback(() => { ... }, [deps]); — used alongside React.memo on child components.',
  analogy_en = 'Saving a phone number in contacts. No need to look it up again each time—just use the saved entry.',
  pitfall_en = 'useCallback alone has little effect. It becomes meaningful only when combined with React.memo.'
WHERE term = 'useCallback' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A reusable Hook you build yourself',
  definition_en = 'A function that combines multiple Hooks into reusable logic. Must be named starting with "use."',
  mechanism_en = 'function useMyHook() { const [state, setState] = useState(); return { state }; }',
  analogy_en = 'An original recipe. Combine basic cooking techniques (Hooks) into your own signature dish (logic).',
  pitfall_en = 'The name must start with "use." This is how React recognizes it as a Hook.'
WHERE term = 'Custom hook' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A mechanism that adds features to functional components',
  definition_en = 'A system that "hooks into" React features—state, lifecycle, context—from functional components. Hook functions start with "use."',
  mechanism_en = 'Built-in Hooks include useState, useEffect, and useContext. You can also create custom Hooks.',
  analogy_en = 'Expansion plugins. Like installing new features (Hooks) onto a smartphone (component).',
  pitfall_en = 'Hooks must be called at the top level of a component. They cannot be used inside conditionals or loops.'
WHERE term = 'Hook' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A component''s life from creation to removal',
  definition_en = 'The sequence of stages a component goes through: mounting, updating, and unmounting. Specific actions can be taken at each stage.',
  mechanism_en = 'In functional components, useEffect handles lifecycle. A cleanup function defines unmount behavior.',
  analogy_en = 'A human life. Born (mount), grow and change (update), pass away (unmount).',
  pitfall_en = 'Lifecycle methods in class components differ from the Hook-based approach in functional components.'
WHERE term = 'Lifecycle' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'When a component first appears on screen',
  definition_en = 'The moment a component is first added to the DOM and becomes visible. The timing for initialization logic.',
  mechanism_en = 'useEffect(() => { ... }, []); with an empty dependency array runs only on mount.',
  analogy_en = 'An actor taking the stage. The component makes its first appearance on screen.',
  pitfall_en = 'If an API is called on mount, guard against calling setState after the component has unmounted.'
WHERE term = 'Mount' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'When a component is removed from screen',
  definition_en = 'The moment a component is removed from the DOM and disappears. The timing for cleanup logic.',
  mechanism_en = 'useEffect(() => { return () => { cleanup }; }, []); defines cleanup to run on unmount.',
  analogy_en = 'An actor leaving the stage. The component exits the screen.',
  pitfall_en = 'Timers and event listeners must be cleaned up on unmount, or they cause memory leaks.'
WHERE term = 'Unmount' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Drawing a component onto the screen',
  definition_en = 'Converting a component''s JSX into DOM elements and displaying them on screen. The most fundamental operation in React.',
  mechanism_en = 'The function component runs and returns JSX, which becomes a virtual DOM, which updates the real DOM.',
  analogy_en = 'Painting on a canvas. Looking at the blueprint (JSX) and drawing the picture (DOM) on the canvas.',
  pitfall_en = 'Don''t write side effects (like API calls) directly during render. Use useEffect instead.'
WHERE term = 'Render' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Redrawing a component when data changes',
  definition_en = 'When state or props change, the component is rendered again. React handles this automatically.',
  mechanism_en = 'A change in state or props triggers re-rendering of the component and its children.',
  analogy_en = 'Redrawing a picture. When a mistake is found, erase and draw again.',
  pitfall_en = 'Unnecessary re-renders hurt performance. Optimize with React.memo, useMemo, and useCallback.'
WHERE term = 'Re-render' AND chapter_id = 8;
