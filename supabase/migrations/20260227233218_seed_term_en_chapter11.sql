/*
  # Seed English translations for Chapter 11 terms (all 15)
  
  Chapter 11 covers CSS Frameworks and Tooling.
  Updates all 15 terms with English translations for:
  one_liner_en, definition_en, mechanism_en, analogy_en, pitfall_en
*/

UPDATE terms SET
  one_liner_en = 'A CSS framework that styles with class names',
  definition_en = 'A utility-first CSS framework. Instead of writing custom CSS, you combine pre-built utility classes like p-4, text-blue-500, and flex directly in your HTML.',
  mechanism_en = 'Add classes to HTML elements for instant styling. During the build step, unused CSS is automatically removed (tree-shaken) to keep the output lightweight.',
  analogy_en = 'Building clothes from LEGO bricks. Snap together small, ready-made pieces (classes) to create any design you want.',
  pitfall_en = 'Class lists can get long, making HTML verbose. Componentization and the @apply directive help keep things manageable.'
WHERE term = 'Tailwind' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'A design approach using small single-purpose classes',
  definition_en = 'A styling methodology where each CSS class does exactly one thing. You combine many small utilities to build up the desired appearance.',
  mechanism_en = 'Classes like p-4 (padding: 1rem) and text-center (text-align: center) each handle one property. You compose them together on elements.',
  analogy_en = 'Cooking with individual seasonings. You add salt, pepper, and soy sauce separately to taste — no premixed blends.',
  pitfall_en = 'This approach differs fundamentally from traditional CSS methodologies like BEM. Teams should agree on a consistent strategy.'
WHERE term = 'Utility-first' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'A copy-and-paste UI component collection',
  definition_en = 'A set of UI components built on Radix UI and Tailwind CSS that you copy directly into your project — not installed as an npm dependency.',
  mechanism_en = 'Run npx shadcn-ui add button to add a component. The code becomes part of your project and is fully customizable.',
  analogy_en = 'A recipe book. Instead of buying pre-made meals, you get the recipes and cook (customize) them yourself.',
  pitfall_en = 'Since the code lives in your project (not a package), updates must be manually pulled in when new versions are released.'
WHERE term = 'Shadcn' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'Writing CSS inside JavaScript files',
  definition_en = 'A technique for defining styles within JavaScript files. Libraries like styled-components and Emotion are popular implementations.',
  mechanism_en = 'Define styles inline with components: const Button = styled.button`color: blue;`;. This makes dynamic, prop-based styling straightforward.',
  analogy_en = 'Clothes with built-in labels. The component and its style sheet are one unit — look at the component and you see its design immediately.',
  pitfall_en = 'Runtime CSS generation can impact performance. Zero-runtime alternatives (like vanilla-extract) have gained popularity for this reason.'
WHERE term = 'CSS-in-JS' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'CSS that is scoped to individual components',
  definition_en = 'A system that automatically makes CSS class names unique per component, preventing style collisions across different parts of the app.',
  mechanism_en = 'Create a file like Button.module.css and import it: import styles from ''./Button.module.css'';. Class names get hashed automatically.',
  analogy_en = 'Private changing rooms. Each component has its own room — its styles can''t leak out or clash with others.',
  pitfall_en = 'To write global styles within a module file, use the :global() wrapper. Otherwise, everything is scoped by default.'
WHERE term = 'CSS modules' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'An extended syntax for writing CSS (Sass format)',
  definition_en = 'Short for "Sassy CSS." A newer Sass syntax that extends CSS with variables, nesting, and mixins. Written in .scss files.',
  mechanism_en = 'Write $color: blue; .btn { color: $color; } using variables and nesting, then compile it down to standard CSS.',
  analogy_en = 'CSS with superpowers. The basics are the same, but useful features like variables and nesting are added on top.',
  pitfall_en = 'Avoid nesting too deeply. Three levels of nesting is a common best-practice limit.'
WHERE term = 'SCSS' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'A CSS preprocessor that adds powerful features',
  definition_en = 'Stands for Syntactically Awesome Style Sheets. A preprocessor that adds variables, nesting, functions, and more to CSS. Comes in two syntaxes: SCSS and the indented syntax.',
  mechanism_en = 'Write .sass or .scss files, then compile them into standard .css files during the build process.',
  analogy_en = 'A draft language for CSS. Write in a more convenient notation, then convert it into regular CSS for browsers.',
  pitfall_en = 'Requires a compilation step. Build tool configuration is needed, though most modern frameworks support it out of the box.'
WHERE term = 'Sass' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'Native variables built into CSS',
  definition_en = 'A CSS-native feature for defining reusable values. Variable names start with --, and values are referenced using var(). Great for managing theme colors centrally.',
  mechanism_en = 'Define with :root { --primary: #3B82F6; } and use with color: var(--primary);. They can also be updated dynamically via JavaScript.',
  analogy_en = 'Sticky notes. Write "main color is this" on a note and reference it whenever you need that value.',
  pitfall_en = 'Not supported in IE11. If legacy browser support is needed, consider Sass variables or a polyfill.'
WHERE term = 'CSS variables' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'The official name for CSS variables',
  definition_en = 'The formal specification name for CSS variables. Properties prefixed with -- define custom values that can be referenced with var().',
  mechanism_en = 'Custom properties follow the cascade and scoping rules. A variable defined on a parent element is available to all its children.',
  analogy_en = 'Same thing as "CSS variables" — custom properties is the official spec name, CSS variables is the common nickname.',
  pitfall_en = 'Names must begin with --. Writing --color works; writing just color as a custom property does not.'
WHERE term = 'Custom properties' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'Styles that only apply within a specific component',
  definition_en = 'Styles that are confined to a single component or file, preventing them from accidentally affecting other parts of the application.',
  mechanism_en = 'Achieved through CSS Modules, Vue''s scoped attribute, Shadow DOM, or similar tools that add unique hashes to class names.',
  analogy_en = 'Apartment units. Redecorating your own unit has no effect on your neighbor''s space.',
  pitfall_en = 'To intentionally style child components from a parent, you need explicit mechanisms like deep selectors.'
WHERE term = 'Scoped styles' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'Styles that apply across the entire app',
  definition_en = 'Styles not confined to any specific component — they affect the entire application. Used for CSS resets, base fonts, and foundational color definitions.',
  mechanism_en = 'Written in files like globals.css or index.css and imported at the application root. Targets elements like body and html.',
  analogy_en = 'Building-wide rules in an apartment complex. Shared spaces and common standards apply to every unit.',
  pitfall_en = 'Too many global styles become hard to manage. Limit them to things that genuinely need to be universal.'
WHERE term = 'Global styles' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'CSS that removes default browser styles',
  definition_en = 'A CSS file that strips all default browser styling (margins, padding, etc.) so you start from a blank canvas with full control.',
  mechanism_en = 'Includes rules like * { margin: 0; padding: 0; }. Popular implementations include Eric Meyer''s Reset CSS and modern-css-reset.',
  analogy_en = 'Wiping a canvas clean. Erase the browser''s default sketch marks so you can paint from scratch.',
  pitfall_en = 'Resetting everything can remove useful defaults. Normalize CSS is an alternative that preserves helpful browser styles.'
WHERE term = 'Reset CSS' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'CSS that evens out differences between browsers',
  definition_en = 'A CSS file that harmonizes inconsistent default styles across different browsers, while preserving useful defaults — unlike a full reset.',
  mechanism_en = 'Adjusts browser-specific differences. For example, it ensures h1 font sizes are consistent across Chrome, Firefox, and Safari.',
  analogy_en = 'Tuning instruments before a concert. Each browser (instrument) is brought into alignment so they all play in harmony.',
  pitfall_en = 'Choose either Reset CSS or Normalize CSS — you don''t need both. Pick one approach and stick with it.'
WHERE term = 'Normalize CSS' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'A tool that transforms CSS with plugins',
  definition_en = 'A tool that processes CSS through JavaScript plugins. Popular plugins include Autoprefixer, CSS Modules, and Tailwind CSS itself.',
  mechanism_en = 'Configured via postcss.config.js. During the build, PostCSS parses your CSS and applies each plugin''s transformations.',
  analogy_en = 'A CSS translator. It takes your CSS, runs it through plugin filters, and outputs the final processed result.',
  pitfall_en = 'PostCSS does nothing by itself. Its power comes entirely from the plugins you add to it.'
WHERE term = 'PostCSS' AND chapter_id = 11;

UPDATE terms SET
  one_liner_en = 'A tool that automatically adds vendor prefixes',
  definition_en = 'A PostCSS plugin that automatically adds vendor prefixes (-webkit-, -moz-, etc.) to your CSS, ensuring compatibility across different browsers.',
  mechanism_en = 'Write standard CSS like display: flex; and Autoprefixer adds the necessary prefixed versions (like -webkit-box) for older browsers.',
  analogy_en = 'Auto-translation. Write one sentence (CSS) and it''s automatically translated into the dialects each browser understands.',
  pitfall_en = 'Most modern browsers no longer need prefixes. Configure your target browsers in .browserslistrc to avoid unnecessary output.'
WHERE term = 'Autoprefixer' AND chapter_id = 11;
