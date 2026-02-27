/*
  # Seed English translations for Chapter 12 terms (Part 1: terms 1-13)
  
  Chapter 12 covers Development Tools and Debugging.
  Updates the first 13 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'An all-in-one development environment',
  definition_en = 'Stands for Integrated Development Environment. A single application that bundles a code editor, debugger, build tools, and more. VS Code and IntelliJ are popular examples.',
  mechanism_en = 'Provides syntax highlighting, auto-completion, debugging, and Git integration — all within one unified interface.',
  analogy_en = 'A professional kitchen. The stove, sink, fridge, and utensils are all in one place, ready to use.',
  pitfall_en = 'Feature-rich IDEs can be resource-heavy. Some developers prefer lighter editors for simple tasks.'
WHERE term = 'IDE' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A text editor designed for writing code',
  definition_en = 'A text editor tailored for programming, with features like syntax highlighting, auto-completion, and extensions. VS Code is the most popular choice.',
  mechanism_en = 'Color-codes different language elements and suggests completions as you type. Functionality is extended through plugins.',
  analogy_en = 'A craftsman''s specialized pen. Unlike a regular pen, it has features built specifically for writing code.',
  pitfall_en = 'Installing too many extensions can slow things down. Keep only the ones you actually use.'
WHERE term = 'Code editor' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A text-based interface for controlling your computer',
  definition_en = 'A text-based interface where you type commands to interact with your computer, instead of clicking through a graphical interface. Also called a console.',
  mechanism_en = 'Type a command and press Enter to execute. Results appear as text output. A shell program interprets and runs the commands.',
  analogy_en = 'A conversation window with your computer. Instead of pointing and clicking, you tell it what to do with words.',
  pitfall_en = 'The learning curve is steep at first, but mastering it dramatically improves productivity.'
WHERE term = 'Terminal' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'The line where you type commands',
  definition_en = 'The specific line in a terminal where you enter commands. It follows a prompt symbol (like $ or >) and executes when you press Enter.',
  mechanism_en = 'Type commands at the cursor position. Command history lets you recall and reuse previous commands.',
  analogy_en = 'An order counter. You walk up and say "I''d like this, please" — placing your command.',
  pitfall_en = 'Be careful with typos. Dangerous commands (like rm -rf /) can cause irreversible damage if run accidentally.'
WHERE term = 'Command line' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A text-command interface for tools',
  definition_en = 'Stands for Command Line Interface. A way to operate programs by typing text commands, as opposed to using a graphical (GUI) interface.',
  mechanism_en = 'Commands accept arguments and options. Tools like npm, git, and docker all provide CLI interfaces.',
  analogy_en = 'A voice assistant. Instead of pressing buttons, you give instructions through words (commands).',
  pitfall_en = 'Use the --help flag when unsure about a command. It shows available options and usage information.'
WHERE term = 'CLI' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A program that interprets and runs commands',
  definition_en = 'The program that takes your typed commands and translates them into instructions the operating system can execute. Common shells include bash, zsh, and fish.',
  mechanism_en = 'Receives commands, passes them to the OS kernel, and returns results. Can also run scripts — sequences of commands saved in a file.',
  analogy_en = 'An interpreter. It translates your human language (commands) into something the computer understands.',
  pitfall_en = 'Different shells have slightly different syntax. A bash script may not work identically in zsh.'
WHERE term = 'Shell' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'The most widely used shell',
  definition_en = 'Stands for Bourne Again SHell. The standard shell on most Linux systems and older macOS versions. The default environment for shell scripting.',
  mechanism_en = 'Configured through .bashrc and .bash_profile files. Supports aliases, environment variables, and scripting.',
  analogy_en = 'A common language. Understood across most operating systems and environments.',
  pitfall_en = 'macOS switched its default shell to zsh starting with Catalina. Adapt your workflow to the environment you''re on.'
WHERE term = 'Bash' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A modern, feature-rich terminal app',
  definition_en = 'A next-generation terminal application with AI features, a modern UI, block-based editing, and collaboration capabilities.',
  mechanism_en = 'Built in Rust for performance. Includes command history search, AI-powered command suggestions, and a streamlined editing experience.',
  analogy_en = 'A high-tech communicator. The traditional terminal upgraded with AI assistance and modern conveniences.',
  pitfall_en = 'Primarily for macOS (with Linux support). Some interactions differ from traditional terminal apps.'
WHERE term = 'Warp' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'Warp''s AI feature that assists with coding',
  definition_en = 'An AI-powered feature within Warp that suggests commands when you describe what you want to do in plain language.',
  mechanism_en = 'Type a natural language request like "find files in this folder" and Warp suggests the appropriate terminal command.',
  analogy_en = 'An experienced assistant. Tell them what you need and they''ll give you the exact steps to do it.',
  pitfall_en = 'Always understand what a suggested command does before running it. Don''t blindly trust AI suggestions.'
WHERE term = 'Warp (as coding agent)' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'An AI tool that writes code autonomously',
  definition_en = 'An AI agent that autonomously performs development tasks — generating code, debugging, and writing tests — based on natural language instructions.',
  mechanism_en = 'Powered by large language models (LLMs). Given a plain-language instruction, it plans and executes multiple steps automatically.',
  analogy_en = 'An AI programmer. Say "build this feature" and it thinks through the problem and writes the code.',
  pitfall_en = 'Never fully delegate without review. Always examine generated code before merging it into your project.'
WHERE term = 'Coding agent' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'An isolated environment for safe experimentation',
  definition_en = 'A contained environment where you can experiment and test freely without affecting production systems. Services like CodeSandbox and StackBlitz provide browser-based sandboxes.',
  mechanism_en = 'Uses virtual environments or containers for isolation. Mistakes and experiments stay contained and don''t impact real systems.',
  analogy_en = 'A sandbox at a playground. A safe, enclosed space where you can build and experiment without consequences.',
  pitfall_en = 'Sandbox behavior may differ from production. Always verify in the real environment before deploying.'
WHERE term = 'Sandbox' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'Browser-built tools for inspecting web pages',
  definition_en = 'Developer tools built into browsers like Chrome and Firefox. They let you inspect HTML/CSS, debug JavaScript, monitor network traffic, and more.',
  mechanism_en = 'Open with F12 or Ctrl+Shift+I. Includes panels like Elements, Console, Network, and Sources.',
  analogy_en = 'Opening the hood of a car. You can peek inside the web page''s engine and make adjustments.',
  pitfall_en = 'Changes made in dev tools only affect your local browser session. They don''t modify the actual website.'
WHERE term = 'Dev tools' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A feature to examine any element on a page',
  definition_en = 'A feature that lets you click on any element on a web page to view and edit its HTML structure and CSS styles. Accessed via right-click then "Inspect."',
  mechanism_en = 'Displays the selected element''s HTML tag, applied CSS rules, and box model. You can edit values live in the browser.',
  analogy_en = 'A magnifying glass. Zoom in on any part of the page to see exactly how it''s built.',
  pitfall_en = 'Edits made through Inspect are temporary. Refreshing the page reverts everything to the original state.'
WHERE term = 'Inspect' AND chapter_id = 12;
