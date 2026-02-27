/*
  # Seed English translations for Chapter 14 terms (Part 2: terms 14-25)
  
  Continues Chapter 14 Git and Version Control.
  Updates the remaining 12 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'Combining two branches into one',
  definition_en = 'Integrating changes from one branch into another. Typically used to bring feature branch work into the main branch.',
  mechanism_en = 'Run git merge <branch-name>. Git auto-merges when possible; conflicts require manual resolution.',
  analogy_en = 'Two rivers joining into one. Separate streams (branches) of work flow together.',
  pitfall_en = 'When conflicts arise, don''t panic. Understand both sets of changes and combine them correctly.'
WHERE term = 'Merge' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'When changes to the same code collide',
  definition_en = 'A situation where multiple people changed the same part of the same file, and Git can''t automatically decide which version to keep. Must be resolved manually.',
  mechanism_en = 'Conflict markers (<<<<<<<, =======, >>>>>>>) show the competing changes. You edit the file to create the correct combined result.',
  analogy_en = 'Two people editing the same paragraph simultaneously. You need to decide whose words to keep, or combine both.',
  pitfall_en = 'Conflicts are a normal part of team development, not a crisis. Stay calm and resolve them methodically.'
WHERE term = 'Merge conflict' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Moving a branch''s starting point forward',
  definition_en = 'An operation that replays a branch''s commits on top of another branch, creating a clean, linear history instead of a merge commit.',
  mechanism_en = 'Run git rebase <branch-name>. Commits are reapplied one by one onto the new base, rewriting history.',
  analogy_en = 'Rearranging chapters in a book. The content stays the same, but the order is cleaned up for readability.',
  pitfall_en = 'Never rebase commits that have already been pushed. It rewrites history and can disrupt teammates'' work.'
WHERE term = 'Rebase' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Temporarily shelving uncommitted changes',
  definition_en = 'A feature that saves your in-progress changes without committing them. Useful when you need to switch branches but aren''t ready to commit.',
  mechanism_en = 'Run git stash to save, git stash pop to restore. Multiple stashes can be managed as a list.',
  analogy_en = 'Tucking something into a desk drawer. You''re not throwing it away — just setting it aside for now.',
  pitfall_en = 'Stashed changes are easy to forget. Check git stash list periodically to avoid losing track.'
WHERE term = 'Stash' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Undoing commits',
  definition_en = 'An operation that removes commits and returns the repository to a specified state. Has three modes: --soft, --mixed (default), and --hard.',
  mechanism_en = 'git reset --hard HEAD~1 completely removes the last commit and its changes. --soft preserves changes in the staging area.',
  analogy_en = 'A time machine to the past. You erase history (commits) as if they never happened.',
  pitfall_en = '--hard permanently deletes changes. Resetting pushed history is especially dangerous and should be avoided.'
WHERE term = 'Reset' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Creating a new commit that undoes a previous one',
  definition_en = 'Creates a new commit that reverses the changes from a specified earlier commit. The original commit stays in history — nothing is erased.',
  mechanism_en = 'Run git revert <commit-ID>. The original commit remains, and a new "undo" commit is added on top.',
  analogy_en = 'Writing "never mind" in the record. The past entry stays, but a new entry officially cancels it.',
  pitfall_en = 'Understand the difference from reset: revert is safer (history is preserved) but adds extra commits.'
WHERE term = 'Revert' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Showing what changed between versions',
  definition_en = 'A feature that displays the differences between file versions or commits — showing exactly what was added, removed, or modified.',
  mechanism_en = 'git diff shows unstaged changes. git diff --staged shows changes ready to commit. Output highlights additions and deletions.',
  analogy_en = 'A spot-the-difference puzzle. Compare two versions side by side to find what changed.',
  pitfall_en = 'Large diffs are hard to read in the terminal. GUI tools and VS Code''s diff viewer make this much easier.'
WHERE term = 'Diff' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'A holding area for changes before committing',
  definition_en = 'An intermediate area between your working directory and the repository where you select which changes to include in the next commit.',
  mechanism_en = 'Add changes with git add. The staging area lets you choose exactly which modifications go into each commit.',
  analogy_en = 'A shopping basket at checkout. You pick items (changes) from the store and place the ones you want to buy (commit) in the basket.',
  pitfall_en = 'Don''t commit everything at once. Group related changes into focused, logical commits.'
WHERE term = 'Staging area' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'A file that tells Git what to ignore',
  definition_en = 'A configuration file that specifies which files and folders Git should not track. Commonly ignores node_modules, .env files, and build outputs.',
  mechanism_en = 'Place a .gitignore file at the project root. Use patterns to specify exclusions.',
  analogy_en = 'A "pretend you didn''t see that" list. Anything on this list, Git will completely ignore.',
  pitfall_en = 'Always add sensitive files (API keys, .env) to .gitignore. Once committed, secrets remain in history even after deletion.'
WHERE term = '.gitignore' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'A request to review and merge your changes',
  definition_en = 'A formal request to merge your branch''s changes into another branch. Serves as the primary unit of code review. Abbreviated as PR.',
  mechanism_en = 'Created on GitHub (or similar platforms). Reviewers examine the code, leave feedback, and approve before merging.',
  analogy_en = 'A formal proposal: "Please accept these changes." It goes through review and, once approved, gets adopted.',
  pitfall_en = 'Keep PRs small and focused. Large PRs are harder to review and more likely to hide problems.'
WHERE term = 'Pull request' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Having others check your code for quality',
  definition_en = 'The practice of having other developers examine your code through pull requests. Catches bugs, improves quality, and shares knowledge across the team.',
  mechanism_en = 'Reviewers leave comments on the PR. "LGTM" (Looks Good To Me) signals approval. Requested changes must be addressed before merging.',
  analogy_en = 'Proofreading a manuscript. Someone else reads your writing (code) and suggests improvements.',
  pitfall_en = 'Reviews are for improvement, not criticism. Keep feedback constructive and focused on the code.'
WHERE term = 'Code review' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'GitHub''s built-in automation system',
  definition_en = 'A GitHub feature that runs automated workflows triggered by events like pushes and pull requests. Used for CI/CD — continuous integration and delivery.',
  mechanism_en = 'Defined in YAML files under .github/workflows/. Automates tasks like running tests, building, and deploying.',
  analogy_en = 'A domino chain. Topple the first piece (push) and a sequence of automated steps follows.',
  pitfall_en = 'Free-tier usage has limits. Avoid triggering unnecessary workflow runs to stay within your quota.'
WHERE term = 'GitHub Actions' AND chapter_id = 14;
