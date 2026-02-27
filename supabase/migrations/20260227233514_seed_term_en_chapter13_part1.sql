/*
  # Seed English translations for Chapter 13 terms (Part 1: terms 1-10)
  
  Chapter 13 covers Development Environments and Package Management.
  Updates the first 10 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'The setup where you write and test code',
  definition_en = 'The environment where programmers write, run, and test their code. This can be a local computer or a cloud-based development server.',
  mechanism_en = 'Includes an editor, runtime, and debugging tools. Runs with separate configuration from the production environment.',
  analogy_en = 'A test kitchen. Separate from the real restaurant (production), it''s where you experiment and practice recipes.',
  pitfall_en = 'Differences between development and production environments can cause "works on my machine" problems. Keep them as similar as possible.'
WHERE term = 'Development environment' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'The live environment real users access',
  definition_en = 'The publicly accessible environment where real users interact with your application. Stability, reliability, and security are top priorities.',
  mechanism_en = 'Code is deployed here only after thorough testing. Requires error monitoring, performance optimization, and security measures.',
  analogy_en = 'The live stage. After rehearsals (development), this is where the show runs in front of the real audience (users).',
  pitfall_en = 'Never edit code directly in production. Always follow the flow: development, then testing, then production deployment.'
WHERE term = 'Production environment' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A pre-production environment for final testing',
  definition_en = 'An environment configured nearly identically to production, used for final verification before a release goes live.',
  mechanism_en = 'Mirrors production''s server setup and database structure. May use copies of production data for realistic testing.',
  analogy_en = 'A full dress rehearsal. Same costumes, lighting, and stage as the real show — the final check before opening night.',
  pitfall_en = 'Staging environments need the same security measures as production. Don''t neglect security for test data either.'
WHERE term = 'Staging environment' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A temporary environment to review changes',
  definition_en = 'A temporary environment auto-generated for each pull request or branch. Services like Vercel and Netlify create these automatically.',
  mechanism_en = 'Triggered by a push or PR, it deploys automatically and generates a unique URL where you can review the changes.',
  analogy_en = 'A fitting room. Try it on (preview) before you buy (merge) — see how changes look before committing.',
  pitfall_en = 'Preview environments are temporary. They''re typically deleted after the PR is merged or closed.'
WHERE term = 'Preview environment' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A configuration value that changes per environment',
  definition_en = 'A way to inject values like API keys, database URLs, and mode settings from outside the code, so the same codebase works differently in each environment.',
  mechanism_en = 'Defined in .env files or hosting platform settings. Accessed in code via process.env.VARIABLE_NAME.',
  analogy_en = 'A name badge. The same uniform (code) is worn everywhere, but the badge (env var) identifies "development" or "production."',
  pitfall_en = 'Never commit .env files to Git. They often contain secrets that could be exposed if the repository is public.'
WHERE term = 'Environment variable' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'The package manager for Node.js',
  definition_en = 'Stands for Node Package Manager. A tool for installing and managing JavaScript packages (libraries). It hosts the world''s largest package registry.',
  mechanism_en = 'Use npm install to add packages. Dependencies are tracked in package.json.',
  analogy_en = 'An app store for code. Search for the package you need and install it with a single command.',
  pitfall_en = 'Pay attention to version compatibility. Conflicts between package dependencies can cause unexpected issues.'
WHERE term = 'npm' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A bundle of code distributed through npm',
  definition_en = 'A reusable unit of code published on the npm registry. React, lodash, and axios are all examples of npm packages.',
  mechanism_en = 'Each package contains code plus a package.json. Published with npm publish and installed with npm install.',
  analogy_en = 'A boxed product delivered to your door. Inside is the code (product) and a README (instruction manual).',
  pitfall_en = 'Check a package''s quality and maintenance status before adopting it. Abandoned packages can become security risks.'
WHERE term = 'npm package' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'The command to add packages to your project',
  definition_en = 'The command that downloads and adds an npm package to your project. Run as npm install <package-name> or simply npm i.',
  mechanism_en = 'Downloads the package into the node_modules folder and records it in package.json.',
  analogy_en = 'Placing an online order. "I''d like this item, please" — and it gets delivered to your project.',
  pitfall_en = 'Understand the difference between global installs (-g) and local installs. Most packages should be installed locally.'
WHERE term = 'npm install' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A command that runs scripts from package.json',
  definition_en = 'Executes named scripts defined in the "scripts" section of package.json. Common examples: npm run dev, npm run build.',
  mechanism_en = 'Looks up the script name in package.json''s "scripts" object and runs the associated command.',
  analogy_en = 'Shortcut buttons. Give long commands a short name, then execute them with one quick command.',
  pitfall_en = 'npm start and npm test can omit "run." All other scripts require the full npm run <name> syntax.'
WHERE term = 'npm run' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A command that runs a package without installing it',
  definition_en = 'Executes an npm package without permanently installing it. Useful for one-off commands and project scaffolding.',
  mechanism_en = 'Temporarily downloads and runs the package, then cleans up afterward. For example: npx create-react-app my-app.',
  analogy_en = 'Renting a tool. You don''t need to buy it — just borrow it for the job and return it when done.',
  pitfall_en = 'Since it downloads each time, npx is slower for frequently used commands. Install those globally instead.'
WHERE term = 'npx' AND chapter_id = 13;
