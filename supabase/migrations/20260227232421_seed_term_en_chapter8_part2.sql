/*
  # Seed English translations for Chapter 8 terms (part 2 of 2)

  Translates the remaining 20 terms of Chapter 8 (terms 21–40).
  Topics: virtual DOM, rendering patterns, context, state management,
  controlled components, side effects, memoization.
*/

UPDATE terms SET
  one_liner_en = 'A lightweight copy of the real DOM',
  definition_en = 'A lightweight JavaScript representation of the actual DOM. React compares the old and new virtual DOMs and applies only the differences to the real DOM.',
  mechanism_en = 'State changes, a new virtual DOM is generated, it is compared (diffed) against the previous one, and only the differences are applied to the real DOM.',
  analogy_en = 'Reviewing changes on a blueprint before modifying the building. Check the plans (virtual DOM) before touching the actual structure (real DOM).',
  pitfall_en = 'The virtual DOM is not so much "fast" as it is "efficient." The key benefit is eliminating unnecessary DOM operations.'
WHERE term = 'Virtual DOM' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Showing different UI based on conditions',
  definition_en = 'Displaying different UI elements depending on a condition. Uses if statements, ternary operators, or the && operator.',
  mechanism_en = '{isLoggedIn ? <Dashboard /> : <Login />} or {showModal && <Modal />}.',
  analogy_en = 'A scene change. "Logged in? Show the dashboard. Not logged in? Show the login screen."',
  pitfall_en = 'The && operator can accidentally render 0 or false. Explicitly convert to a boolean first.'
WHERE term = 'Conditional rendering' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Dynamically rendering a list from an array',
  definition_en = 'Using map() on an array to dynamically generate multiple elements for display.',
  mechanism_en = '{items.map(item => <li key={item.id}>{item.name}</li>)} — a key prop is required.',
  analogy_en = 'Making attendance cards from a roster. For each person (element) in the list (array), create a card (JSX).',
  pitfall_en = 'Omitting the key triggers a warning. Keys must be unique within the list. Array indexes are a last resort.'
WHERE term = 'List rendering' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A special prop that uniquely identifies list items',
  definition_en = 'A special prop used during list rendering to uniquely identify each element. React needs it for efficient updates.',
  mechanism_en = 'Specified inside map: <Item key={item.id} />. Must be unique among siblings.',
  analogy_en = 'Student ID numbers. Even if two students share the same name, their numbers tell them apart.',
  pitfall_en = 'Using array indexes as keys causes issues during reordering. Prefer unique IDs whenever possible.'
WHERE term = 'Key prop' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A special prop that receives a component''s nested content',
  definition_en = 'A special prop that captures whatever is placed between a component''s opening and closing tags.',
  mechanism_en = '<Card>{children}</Card> — inside Card, access it via props.children.',
  analogy_en = 'The contents of an envelope. Open the envelope (parent component) and find a letter (children) inside.',
  pitfall_en = 'Children can be anything—strings, elements, even functions. Defining the expected type makes it safer.'
WHERE term = 'Children prop' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Groups elements without adding extra DOM nodes',
  definition_en = 'A special component that groups multiple elements without creating an actual DOM node.',
  mechanism_en = '<React.Fragment>...</React.Fragment> or the shorthand <>...</>.',
  analogy_en = 'A transparent folder. It holds documents (elements) together, but the folder itself is invisible.',
  pitfall_en = 'The shorthand <></> does not support the key prop. Use <Fragment key={...}> when a key is needed.'
WHERE term = 'Fragment' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Sharing data across the component tree without props',
  definition_en = 'A mechanism for sharing data throughout the component tree without passing props manually. Used for themes, authentication, and similar global data.',
  mechanism_en = 'createContext() to create, Provider to wrap, useContext() to consume.',
  analogy_en = 'A school PA system. Information reaches every classroom (component) at once.',
  pitfall_en = 'Don''t put everything in Context. Data that updates frequently can cause performance problems.'
WHERE term = 'Context' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'The component that supplies a Context value',
  definition_en = 'A component that provides a Context''s value to all descendant components via the value prop.',
  mechanism_en = '<MyContext.Provider value={...}>...</MyContext.Provider>',
  analogy_en = 'The broadcast room. Information (value) sent from here reaches every classroom (descendant).',
  pitfall_en = 'When the Provider''s value changes, every component using useContext re-renders.'
WHERE term = 'Context provider' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A function that updates state based on actions',
  definition_en = 'A pure function that receives the current state and an action, then returns a new state. Used for complex state logic.',
  mechanism_en = 'function reducer(state, action) { switch(action.type) { ... } }',
  analogy_en = 'A bank teller. Processes requests like "deposit" or "withdrawal" (actions) and updates the balance (state) accordingly.',
  pitfall_en = 'Reducers must be pure functions. Do not include side effects like API calls.'
WHERE term = 'Reducer' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A Hook for managing complex state with a reducer',
  definition_en = 'A Hook that manages state using the reducer pattern. Better suited than useState for complex state logic.',
  mechanism_en = 'const [state, dispatch] = useReducer(reducer, initialState); — update with dispatch({type: ''INCREMENT''}).',
  analogy_en = 'Instruction-based operations. Tell it "what to do" (action), and it follows the prescribed procedure (reducer).',
  pitfall_en = 'For simple state, useState is enough. Consider useReducer when the update logic gets complex.'
WHERE term = 'useReducer' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A system for managing app-wide state',
  definition_en = 'A system for centrally managing application-wide data (state) so it is accessible wherever needed.',
  mechanism_en = 'Implemented using Context API, Redux, Zustand, Jotai, or similar libraries. Choice depends on scale.',
  analogy_en = 'A company information system. All employees (components) can access the data they need.',
  pitfall_en = 'A heavy state management library is overkill for a small app. Match the tool to the project''s scale.'
WHERE term = 'State management' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A centralized location for storing state',
  definition_en = 'A central repository for application state. A concept used in Redux, Zustand, and similar libraries.',
  mechanism_en = 'A store is created to hold state. Components read from the store and dispatch actions to update it.',
  analogy_en = 'A bank vault. Money (state) is kept in one place with clear rules for deposits and withdrawals.',
  pitfall_en = 'Don''t dump everything into the store. Only truly global state belongs there.'
WHERE term = 'State store' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'State shared across the entire application',
  definition_en = 'State that is accessible and updatable from anywhere in the application, not limited to a single component.',
  mechanism_en = 'Implemented with Context, Redux, Zustand, etc. Common uses: logged-in user, theme, language settings.',
  analogy_en = 'A school bulletin board. Every student (component) can see the posted information.',
  pitfall_en = 'Making everything global makes it hard to trace where changes come from. Keep global state to a minimum.'
WHERE term = 'Global state' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'State that lives only inside one component',
  definition_en = 'State used only within a specific component. Typically managed with useState.',
  mechanism_en = 'const [value, setValue] = useState(); — state scoped entirely within the component.',
  analogy_en = 'A personal notebook. Only you (the component) can see and update it.',
  pitfall_en = 'Don''t promote local state to global unless it truly needs to be shared. Start local and lift only when necessary.'
WHERE term = 'Local state' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Passing props through many layers of components',
  definition_en = 'The problem of threading props through intermediate components just to reach a deeply nested child. The middle components don''t even use the data.',
  mechanism_en = 'Parent passes to child, child to grandchild, grandchild to great-grandchild... each layer forwarding the same props.',
  analogy_en = 'A game of telephone. You really want to tell the last person, but the message has to pass through everyone in between.',
  pitfall_en = 'When prop drilling gets deep, consider introducing Context or a state management library.'
WHERE term = 'Prop drilling' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Moving shared state up to a common parent',
  definition_en = 'When multiple child components need to share state, the state is moved to their closest common parent.',
  mechanism_en = 'The parent uses useState and passes the value and setter down as props.',
  analogy_en = 'A shared refrigerator. Instead of each room (child) having its own fridge, put one in the common area (parent) for everyone.',
  pitfall_en = 'Lifting too much state makes the parent bloated. Only lift what truly needs to be shared.'
WHERE term = 'Lifting state' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'A form element whose value is controlled by React',
  definition_en = 'A pattern where a form element''s (input, select, etc.) value is managed by React state.',
  mechanism_en = '<input value={state} onChange={e => setState(e.target.value)} /> — both value and onChange are required.',
  analogy_en = 'Remote control. React (the remote) fully controls the TV (input element).',
  pitfall_en = 'Setting value without onChange makes the input read-only. Always use both together.'
WHERE term = 'Controlled component' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Any interaction with the "outside world" beyond rendering',
  definition_en = 'Operations other than rendering the UI—API calls, DOM manipulation, logging, timer setup, etc.',
  mechanism_en = 'Execute side effects inside useEffect. Do not write them directly during rendering.',
  analogy_en = 'Cleanup after cooking. Cooking (rendering) is the main task; washing dishes and tidying up (side effects) are the extra work.',
  pitfall_en = 'Side effects belong in useEffect. Writing them during render leads to bugs.'
WHERE term = 'Side effect' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'An array that controls when useEffect re-runs',
  definition_en = 'The second argument of useEffect, useMemo, and useCallback. When any value in this array changes, the effect re-runs.',
  mechanism_en = 'useEffect(() => {}, [dep1, dep2]); — re-runs only when dep1 or dep2 changes.',
  analogy_en = 'A watch list. "If any of these people (dependencies) move, alert me."',
  pitfall_en = 'Missing a dependency causes stale value references. Follow ESLint''s exhaustive-deps rule.'
WHERE term = 'Dependency array' AND chapter_id = 8;

UPDATE terms SET
  one_liner_en = 'Caching results to avoid redundant calculations',
  definition_en = 'A technique that caches the result of a computation for a given input so the same calculation is not repeated unnecessarily.',
  mechanism_en = 'Achieved with React.memo(), useMemo, and useCallback. If dependencies are unchanged, the cached result is reused.',
  analogy_en = 'Saving test answers. If the same question appears again, use the saved answer.',
  pitfall_en = 'Memoization itself has a cost. Use it only where needed—premature optimization can make things worse.'
WHERE term = 'Memoization' AND chapter_id = 8;
