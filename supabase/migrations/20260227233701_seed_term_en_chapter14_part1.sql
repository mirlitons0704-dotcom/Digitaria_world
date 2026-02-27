/*
  # Seed English translations for Chapter 14 terms (Part 1: terms 1-13)
  
  Chapter 14 covers Git and Version Control.
  Updates the first 13 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'A system that tracks changes to your code',
  definition_en = 'A distributed version control system. It records every change made to files, lets you revert to any past state, and enables multiple people to work on the same project simultaneously.',
  mechanism_en = 'Changes are saved as commits. Branches allow parallel work, and merges bring branches together. Local and remote repositories stay in sync.',
  analogy_en = 'A save system with a time machine. You can always go back to any previous save point.',
  pitfall_en = 'Git concepts can be confusing at first. The best way to learn is by using it hands-on, a little at a time.'
WHERE term = 'Git' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'A cloud platform for Git repositories',
  definition_en = 'A cloud service for hosting Git repositories. Used for code sharing, team collaboration, and publishing open-source projects.',
  mechanism_en = 'Hosts remote repositories. Also provides features like pull requests, issues, and GitHub Actions for automation.',
  analogy_en = 'Social media for code. Share your work, browse others'' projects, and collaborate together.',
  pitfall_en = 'Git and GitHub are different things. Git is the version control tool; GitHub is a service built on top of Git.'
WHERE term = 'GitHub' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'A storage location for a project and its history',
  definition_en = 'The place that stores all of a project''s files along with their complete change history. Often shortened to "repo."',
  mechanism_en = 'Created with git init. The .git folder stores all history. Repositories exist both locally and remotely.',
  analogy_en = 'A project vault. It holds the code and the entire record of every change ever made.',
  pitfall_en = 'Deleting a repository erases its history too. Back up important repositories.'
WHERE term = 'Repository' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Copying a remote repository to your machine',
  definition_en = 'Creating a complete local copy of a remote repository, including all files, branches, and history.',
  mechanism_en = 'Run git clone <URL>. The entire repository — every branch and every commit — is downloaded.',
  analogy_en = 'Photocopying an entire library book. You get not just the content, but all its revision notes too.',
  pitfall_en = 'Cloning large repositories can take a while. Shallow clones (--depth) can speed things up when you don''t need full history.'
WHERE term = 'Clone' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Copying someone else''s repo to your own account',
  definition_en = 'Creating a copy of another user''s GitHub repository under your own account. This is the first step in contributing to open-source projects.',
  mechanism_en = 'Click the "Fork" button on GitHub. The link to the original repo is maintained, allowing you to submit pull requests back.',
  analogy_en = 'Copying a recipe into your own notebook. You''re free to modify it, and if it turns out great, you can suggest changes to the original author.',
  pitfall_en = 'Fork and Clone are different. Fork copies the repo on the server (GitHub). Clone downloads it to your local machine.'
WHERE term = 'Fork' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Creating a parallel line of development',
  definition_en = 'An independent line of work that diverges from the main codebase. Lets you develop features or fix bugs without affecting the main code.',
  mechanism_en = 'Create with git branch <name>, switch with git checkout <name> or git switch <name>.',
  analogy_en = 'A parallel universe. You can experiment in a separate timeline without changing the main story.',
  pitfall_en = 'Too many branches become hard to manage. Delete branches once they''re merged and no longer needed.'
WHERE term = 'Branch' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'The primary branch of a project',
  definition_en = 'The default, authoritative branch of a project. Previously called "master," the standard name is now "main."',
  mechanism_en = 'Created automatically when a repository is initialized. Usually the branch deployed to production.',
  analogy_en = 'The official storyline. Spin-offs (feature branches) may exist, but main is the canonical version.',
  pitfall_en = 'Most teams avoid committing directly to main. Changes are merged through pull requests instead.'
WHERE term = 'Main branch' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'A temporary branch for building a specific feature',
  definition_en = 'A short-lived branch created for developing a specific feature or fix. Once complete, it''s merged into main and deleted.',
  mechanism_en = 'Branched from main. Naming conventions like feature/login or fix/bug-123 are common.',
  analogy_en = 'A laboratory. Experiment with a new invention (feature) safely, then bring successful results into the main project.',
  pitfall_en = 'Branches left unmerged for too long diverge significantly from main. Merge or rebase frequently to stay current.'
WHERE term = 'Feature branch' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Switching to a different branch',
  definition_en = 'A command to switch your working context to a different branch. Can also restore a specific file to a previous state.',
  mechanism_en = 'Run git checkout <branch-name> to switch. git checkout -b <name> creates and switches in one step.',
  analogy_en = 'Pulling a different book from the shelf. You change which book (branch) you''re currently reading and working on.',
  pitfall_en = 'Switching without saving your changes can cause them to be lost. Use git stash to temporarily save uncommitted work.'
WHERE term = 'Checkout' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Saving changes as a recorded snapshot',
  definition_en = 'Recording file changes as a permanent entry in the repository''s history. Each commit pairs the changes with a descriptive message.',
  mechanism_en = 'Stage changes with git add, then record with git commit -m "message". Each commit receives a unique hash ID.',
  analogy_en = 'A save point in a game. You preserve your progress so you can always return to this exact state.',
  pitfall_en = 'Write specific commit messages. "Fixed stuff" is unhelpful — "Fix login error message display" tells the story.'
WHERE term = 'Commit' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'The three core Git operations',
  definition_en = 'The fundamental trio of Git operations: commit (record changes), push (send to remote), and pull (get from remote). This cycle repeats throughout development.',
  mechanism_en = 'Work locally, commit your changes, push them to the remote server. Pull others'' changes to stay synchronized.',
  analogy_en = 'Email correspondence. Draft and save (commit), send (push), and receive (pull).',
  pitfall_en = 'Pushing without pulling first can cause errors. Make it a habit to pull before starting work.'
WHERE term = 'Commit/push/pull' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Sending local commits to the remote repository',
  definition_en = 'Uploading your local commits to the remote repository so they''re shared with the team.',
  mechanism_en = 'Run git push origin <branch-name>. If the remote branch doesn''t exist yet, it''s created automatically.',
  analogy_en = 'Mailing a letter. You drop your written commits into the mailbox (remote) for delivery.',
  pitfall_en = 'Force push (-f) overwrites remote history and is dangerous. Use it with extreme caution, especially on shared branches.'
WHERE term = 'Push' AND chapter_id = 14;

UPDATE terms SET
  one_liner_en = 'Fetching remote changes to your local machine',
  definition_en = 'Downloading changes from the remote repository and merging them into your local branch. Combines fetch and merge in one step.',
  mechanism_en = 'Run git pull origin <branch-name>. Synchronizes your local branch with the latest remote state.',
  analogy_en = 'Checking the mailbox. You receive the letters (remote changes) and read them (merge into your code).',
  pitfall_en = 'Merge conflicts can occur during a pull. When they do, you''ll need to resolve them manually.'
WHERE term = 'Pull' AND chapter_id = 14;
