/*
  # Seed English translations for Chapter 13 terms (Part 2: terms 11-20)
  
  Continues Chapter 13 Development Environments and Package Management.
  Updates the remaining 10 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'An alternative package manager to npm',
  definition_en = 'A JavaScript package manager developed by Facebook (now Meta). Known for faster installs and stricter dependency management than npm.',
  mechanism_en = 'Use yarn add to install packages. yarn.lock pins exact dependency versions. Compatible with npm packages.',
  analogy_en = 'A different delivery service. It delivers the same packages (code), but uses a slightly different logistics system.',
  pitfall_en = 'Don''t mix npm and Yarn in the same project. Choose one and use it consistently.'
WHERE term = 'Yarn' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A reusable unit of distributed code',
  definition_en = 'A bundled piece of code designed for distribution and reuse. Packages can contain libraries, frameworks, or tools, and are managed by npm or Yarn.',
  mechanism_en = 'Defined by a package.json and version-controlled. A package can depend on other packages, forming a dependency tree.',
  analogy_en = 'A model kit. A box containing all the parts (code) needed to build something, ready to assemble.',
  pitfall_en = 'Check package licenses before use. Some licenses prohibit commercial use.'
WHERE term = 'Package' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'Multiple packages (plural form)',
  definition_en = 'The collection of all packages a project depends on. Refers to the full set of external code libraries used by a project.',
  mechanism_en = 'Listed in package.json under dependencies and devDependencies sections.',
  analogy_en = 'An inventory list. All the parts (packages) the project needs, cataloged in one place.',
  pitfall_en = 'Periodically remove unused packages. They increase security risk and bloat the final bundle size.'
WHERE term = 'Packages' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A package your project needs to run',
  definition_en = 'An external package that your project requires to function. Production dependencies are listed under "dependencies" in package.json.',
  mechanism_en = 'Recorded in package.json''s dependencies field. Automatically installed when someone runs npm install.',
  analogy_en = 'Ingredients for a recipe. You need these specific items (packages) to make the dish (project) work.',
  pitfall_en = 'Too many dependencies make maintenance harder. Only add packages that are truly necessary.'
WHERE term = 'Dependency' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A package needed only during development',
  definition_en = 'A package required only for development or testing — not needed when the app runs in production. Examples: test runners, build tools, linters.',
  mechanism_en = 'Installed with npm install --save-dev or -D. Listed under devDependencies in package.json.',
  analogy_en = 'Kitchen utensils. They''re needed to prepare the meal (build), but aren''t served to the customer (production).',
  pitfall_en = 'Don''t accidentally put production dependencies in devDependencies. They won''t be included in production builds.'
WHERE term = 'Dev dependency' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'The configuration file for a Node.js project',
  definition_en = 'The central configuration file for any Node.js project. It records the project name, version, dependencies, scripts, and other metadata — essentially the project''s resume.',
  mechanism_en = 'Written in JSON format. Created with npm init. Contains fields like dependencies, scripts, name, and version.',
  analogy_en = 'A project''s resume. Lists its name, what it can do (scripts), and what it needs (dependencies).',
  pitfall_en = 'When editing manually, be careful not to break JSON syntax. A missing comma can cause parse errors.'
WHERE term = 'Package.json' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A file that locks exact package versions',
  definition_en = 'An auto-generated file that records the exact version of every installed package. Ensures all team members and CI systems use identical versions.',
  mechanism_en = 'Generated and updated by npm install. Records precise versions for the entire dependency tree, including nested dependencies.',
  analogy_en = 'A detailed recipe note. Instead of "a pinch of salt," it records "exactly 3 grams" — precise versions for reproducibility.',
  pitfall_en = 'Always commit this file to Git. Without it, different environments may install different versions.'
WHERE term = 'Package-lock.json' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'The folder where installed packages are stored',
  definition_en = 'The directory that contains all packages installed via npm or Yarn, including dependencies of dependencies. Can grow very large.',
  mechanism_en = 'Created and updated automatically by npm install. Contains the full dependency tree — often thousands of files.',
  analogy_en = 'A warehouse. All the ordered items (packages) are stored here, ready to be used by the project.',
  pitfall_en = 'Never commit node_modules to Git. Add it to .gitignore and recreate it with npm install on each machine.'
WHERE term = 'Node modules' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A version numbering system with meaning',
  definition_en = 'A versioning convention using MAJOR.MINOR.PATCH format (e.g., 2.1.3). The type of change determines which number increments.',
  mechanism_en = 'MAJOR: breaking changes. MINOR: new features, backward-compatible. PATCH: bug fixes only.',
  analogy_en = 'Movie sequel numbering. 1 to 2 is a major new story. 1.0 to 1.1 adds bonus scenes. 1.0.0 to 1.0.1 fixes a typo.',
  pitfall_en = 'In package.json, ^2.1.0 allows any 2.x.x update, while ~2.1.0 only allows 2.1.x updates. Know the difference.'
WHERE term = 'Semantic versioning' AND chapter_id = 13;

UPDATE terms SET
  one_liner_en = 'A file that pins dependency versions',
  definition_en = 'A general term for files like package-lock.json (npm) and yarn.lock (Yarn) that record the exact installed versions of all dependencies.',
  mechanism_en = 'Auto-generated during installation. Records the complete dependency tree with precise versions in a structured format.',
  analogy_en = 'Cryogenic preservation. Freezing the exact state so you can reproduce it identically at any time.',
  pitfall_en = 'Always include lock files in version control. They''re essential for consistent builds across environments and CI.'
WHERE term = 'Lock file' AND chapter_id = 13;
