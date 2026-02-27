/*
  # Seed English translations for Chapter 2 terms

  Translates all 5 English fields for the 25 terms in Chapter 2.
  Topics: file formats (.TXT, .MD, .HTML, .CSS, .JS, .TS, .JSON,
  .JPG/JPEG, .PNG, .SVG, .PDF, .CSV, .YAML, .env, .SCSS, .JSX, .TSX, .SQL),
  Format, Metadata, File metadata, Config file, Configuration, Tech stack, README.
*/

UPDATE terms SET
  one_liner_en = 'A plain-text format that stores nothing but characters',
  definition_en = 'A file format for saving plain text—pure character data with no formatting. It is the most basic file type and can be opened on virtually any computer.',
  mechanism_en = 'Only character data is stored; no bold, color, or other styling information is included. Created and edited with text editors like Notepad.',
  analogy_en = 'A note written in black pen on white paper. No colors, no decoration—just simple text anyone can read.',
  pitfall_en = 'Saving in Word produces a .docx, not a .txt. If you need a pure text file, you must choose "plain text" in the "Save As" dialog.'
WHERE term = '.TXT' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A text format that uses simple symbols for formatting',
  definition_en = 'A Markdown-format file. While still plain text, it uses symbols like # and * to express structure such as headings and bullet lists.',
  mechanism_en = '# creates headings, * or - creates bullet lists, ** makes text bold, and [text](URL) creates links. Widely used for GitHub READMEs and documentation.',
  analogy_en = 'A standardized version of personal shorthand notes. Just as you might use bullets for lists and underlines for emphasis, Markdown formalizes these conventions so everyone can share them.',
  pitfall_en = 'You do need to learn the Markdown syntax, but mastering just 5 or 6 symbols covers the essentials: # for headings, - for lists, and ** for bold.'
WHERE term = '.MD' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'The format that defines the structure of a web page',
  definition_en = 'Stands for HyperText Markup Language. A language for describing the structure of web pages. Elements like headings, paragraphs, links, and images are expressed by wrapping them in "tags."',
  mechanism_en = 'Tags such as <html>, <body>, <h1>, and <p> define the document structure. A browser reads this file and renders it as a web page.',
  analogy_en = 'Like a building blueprint that marks "this is a pillar," "this is a wall," "this is a door." HTML marks "this is a heading," "this is a paragraph," "this is a link."',
  pitfall_en = 'HTML alone looks plain. To add colors and layout, you need CSS. Think of HTML as the "skeleton" and CSS as the "interior design."'
WHERE term = '.HTML' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'The format that styles the appearance of a web page',
  definition_en = 'Stands for Cascading Style Sheets. A language for specifying the visual appearance—colors, sizes, layout—of structures built with HTML.',
  mechanism_en = 'A selector picks the target element, then properties and values define the style. Example: h1 { color: blue; } means "make all h1 tags blue."',
  analogy_en = 'Interior design for a house. Choosing wallpaper colors, arranging furniture, adjusting lighting—everything that makes the space look good.',
  pitfall_en = 'The "C" in CSS stands for "Cascading," meaning later-declared styles override earlier ones. Without understanding this override behavior, debugging can get confusing.'
WHERE term = '.CSS' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A program file that adds interactivity to web pages',
  definition_en = 'A file written in JavaScript. It adds interactive behavior—click handling, animations, data processing—to web pages.',
  mechanism_en = 'When a browser loads an HTML page, it also loads and executes any .js files. These scripts can respond to user actions and communicate with servers.',
  analogy_en = 'The "gadget installer" in a house. Opening a door triggers the lights, pressing a button starts music—.js files add dynamic behavior to the structure.',
  pitfall_en = '"Java" and "JavaScript" are completely different languages. Despite the similar names, their syntax and use cases are entirely separate.'
WHERE term = '.JS' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'JavaScript enhanced with type safety',
  definition_en = 'A file written in TypeScript. TypeScript extends JavaScript with a "type" system, enabling safer and more maintainable code.',
  mechanism_en = 'You can assign types to variables and function parameters. If you use the wrong type, the compiler flags an error before runtime. The code is ultimately compiled down to JavaScript.',
  analogy_en = 'A structured application form with labeled fields: "enter a number here," "enter text there." Pre-defined slots prevent mistakes.',
  pitfall_en = 'TypeScript has a learning curve, but in large projects it catches bugs early, often saving more time than it costs.'
WHERE term = '.TS' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A lightweight format for structured data',
  definition_en = 'Stands for JavaScript Object Notation. A lightweight data format that stores data as key-value pairs. Widely used for configuration files and API communication.',
  mechanism_en = '{ } denotes objects, [ ] denotes arrays. Strings, numbers, booleans, null, objects, and arrays can be nested to create structured data.',
  analogy_en = 'A neatly organized address book. Each entry is labeled: "name: ...", "phone: ...", "address: ..."—information sorted with clear labels.',
  pitfall_en = 'JSON does not support comments. If you need to leave notes in a config file, consider an alternative format like YAML.'
WHERE term = '.JSON' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A compressed image format ideal for photographs',
  definition_en = 'An image format created by the Joint Photographic Experts Group. It efficiently compresses images with many colors, like photographs, and is one of the most widely used image formats.',
  mechanism_en = 'Uses "lossy compression," discarding details the human eye can barely notice to reduce file size. Repeated saving gradually degrades image quality.',
  analogy_en = 'Like converting CD music to MP3. Imperceptible details are trimmed away to make the file smaller.',
  pitfall_en = 'Each edit-and-save cycle slightly degrades quality (generation loss). Keep the original file for editing, and export to JPG only for the final version.'
WHERE term = '.JPG/JPEG' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A high-quality image format that supports transparency',
  definition_en = 'Stands for Portable Network Graphics. An image format that supports transparency (transparent backgrounds) and preserves quality through repeated saves.',
  mechanism_en = 'Uses "lossless compression," which reduces file size without losing any quality. It can store transparency (alpha channel), making it ideal for logos and icons with transparent backgrounds.',
  analogy_en = 'A document in a clear plastic sleeve. The background shows through, so you can layer it on top of other images.',
  pitfall_en = 'PNG files tend to be larger than JPGs. Use JPG for photographs and PNG for logos, icons, and screenshots.'
WHERE term = '.PNG' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A vector image that stays sharp at any size',
  definition_en = 'Stands for Scalable Vector Graphics. A vector-based image format that describes shapes using mathematical formulas of points and lines. It never gets blurry, no matter how much you zoom in.',
  mechanism_en = 'Shapes are defined by instructions like "draw a line from point (100,50) to point (200,150)." The image is recalculated at display time, so it stays crisp at any scale.',
  analogy_en = 'Like an architectural blueprint. Because it describes "draw a line here, draw a circle there," it reproduces perfectly whether printed large or small.',
  pitfall_en = 'Not suitable for complex images like photographs. Best used for simple icons, logos, shapes, and charts.'
WHERE term = '.SVG' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A document format that looks the same everywhere',
  definition_en = 'Stands for Portable Document Format. A file format that displays with the exact same layout on any device and any operating system. Ideal for sharing print-ready documents.',
  mechanism_en = 'Fonts, images, and layout information are all embedded in the file. The document renders exactly as the creator intended, regardless of the viewing environment.',
  analogy_en = 'A printed page converted directly to digital form. Just like paper, it looks the same to everyone who views it.',
  pitfall_en = 'PDFs are intentionally hard to edit. For modifications, work with the original Word or design file and export to PDF only when finished.'
WHERE term = '.PDF' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A simple tabular data format separated by commas',
  definition_en = 'Stands for Comma-Separated Values. The simplest tabular data format, where values are separated by commas. Can be opened in spreadsheet software like Excel.',
  mechanism_en = 'Each line represents one record, and commas mark column boundaries. Example: name,age,occupation',
  analogy_en = 'A table without visible grid lines. Commas serve as markers that say "a new column starts here."',
  pitfall_en = 'If the data itself contains commas, they get confused with delimiters. In that case, the value must be wrapped in double quotes.'
WHERE term = '.CSV' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A human-readable configuration file format',
  definition_en = 'Stands for YAML Ain''t Markup Language. A configuration file format that uses indentation to express structure, designed to be easy for humans to read.',
  mechanism_en = 'Indentation (e.g., 2 spaces) represents hierarchy, and data is written as "key: value" pairs. It can express the same data structures as JSON, but in a more readable way. Comments are supported.',
  analogy_en = 'A neatly organized notebook. The indentation makes the hierarchy clear at a glance, so you can instantly understand the structure.',
  pitfall_en = 'Using tabs instead of spaces causes errors (only spaces are allowed). Also, misaligned indentation directly translates to structural errors, so pay close attention to spacing.'
WHERE term = '.YAML' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A file that stores secret configuration values',
  definition_en = 'A file for defining environment variables. It stores sensitive information—API keys, passwords, database connection strings—that must not be exposed publicly.',
  mechanism_en = 'Written in the format KEY=value. The application reads this file at startup and uses the values as environment variables.',
  analogy_en = 'Important documents locked in a safe. Sensitive information that no one else should see, stored where only the application can access it.',
  pitfall_en = 'Never push this file to GitHub or any public repository! Adding it to .gitignore so it doesn''t get uploaded is an absolute rule.'
WHERE term = '.env' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'An enhanced version of CSS with extra features',
  definition_en = 'Stands for Sassy CSS. An extension of CSS that adds convenient features like variables, nesting, and mixins. Compiled into standard CSS before use.',
  mechanism_en = 'Supports variables like $color: blue; and selector nesting. These features make managing large-scale stylesheets much more efficient.',
  analogy_en = 'A text editor with macro capabilities for CSS. Frequently used patterns can be written in shorthand, and values can be managed through variables.',
  pitfall_en = 'Browsers cannot read SCSS directly, so it must be compiled to CSS first. This requires a build tool to be configured.'
WHERE term = '.SCSS' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A format that lets you write HTML inside JavaScript',
  definition_en = 'Stands for JavaScript XML. A syntax extension used in React to describe UI. It lets you embed HTML-like markup directly inside JavaScript code.',
  mechanism_en = 'You can write things like return <div className="card">Hello</div>; directly in JavaScript. Under the hood, this is transformed into React function calls.',
  analogy_en = 'A theater script where dialogue and stage directions are written together. "What to display" and "how it behaves" are managed in one place.',
  pitfall_en = 'JSX has slightly different rules from HTML: use className instead of class, and htmlFor instead of for.'
WHERE term = '.JSX' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'The TypeScript version of JSX',
  definition_en = 'A file format for using JSX syntax with TypeScript. It lets you write React components with full type safety. The most common format in modern React development.',
  mechanism_en = 'Combines all JSX features with TypeScript''s type checking. You can define types for props and state, and the compiler warns you when they are used incorrectly.',
  analogy_en = 'JSX with a quality-control inspector attached. It pre-checks your code for mistakes before anything runs.',
  pitfall_en = 'Writing type definitions takes extra effort, but in large projects the bug-prevention benefits are well worth it.'
WHERE term = '.TSX' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A language for sending commands to a database',
  definition_en = 'Stands for Structured Query Language. A language for querying, inserting, updating, and deleting data in a database.',
  mechanism_en = 'Uses English-like syntax to query a database. For example: SELECT * FROM users WHERE age > 20;',
  analogy_en = 'A request to a librarian: "Give me a list of all members over 20 years old." You describe the data you want, and the librarian (database) retrieves it for you.',
  pitfall_en = 'SQL injection is a well-known attack vector. Inserting raw user input directly into SQL queries is dangerous—always use parameterized queries.'
WHERE term = '.SQL' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'The structure or specification of data',
  definition_en = 'A defined standard for how data is structured and represented. File formats like .txt and .json are types of formats.',
  mechanism_en = 'The same information can be expressed in multiple formats—text, JSON, XML, and more. Choosing the right format depends on the use case.',
  analogy_en = 'Like writing the same address in different styles: "123 Main St, Apt 4" versus a structured postal form. Same information, different conventions.',
  pitfall_en = '"Format" has another meaning: to initialize or wipe a storage device. "Formatting a hard drive" means erasing all its data.'
WHERE term = 'Format' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'Data about data',
  definition_en = 'Information that describes other data rather than being the data itself. Examples include creation date, modification date, author, file size, and format.',
  mechanism_en = 'Files carry metadata alongside their main content. A photo, for instance, may contain the date it was taken, camera model, and even GPS coordinates.',
  analogy_en = 'The colophon at the back of a book. It isn''t the book''s content, but it tells you when it was published and who wrote it—information about the information.',
  pitfall_en = 'Photo metadata can include location data. Before uploading to social media, check whether the metadata contains anything you wouldn''t want to share publicly.'
WHERE term = 'Metadata' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'Information attached to a file beyond its contents',
  definition_en = 'Data about a file other than its content—file name, size, creation date, modification date, and access permissions.',
  mechanism_en = 'Managed by the operating system''s file system. On Windows, view it via "Properties"; on Mac, via "Get Info."',
  analogy_en = 'A tracking label stuck on a document: "created on...", "last updated by...", "size: ... bytes"—administrative information.',
  pitfall_en = 'Copying a file may reset the creation date to the time of the copy. Be aware of this if you need to preserve original timestamps.'
WHERE term = 'File metadata' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A file that stores an application''s settings',
  definition_en = 'A file containing settings that control how an application behaves. Can be in various formats such as JSON, YAML, or .env.',
  mechanism_en = 'Read by the application at startup. By editing the config file, you can change the app''s behavior without modifying its code.',
  analogy_en = 'The settings menu on a home appliance. You can customize how it operates without changing the hardware itself.',
  pitfall_en = 'A syntax error in a config file can prevent the app from starting. YAML is especially strict about indentation, so be careful.'
WHERE term = 'Config file' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'The settings or setup of a system',
  definition_en = 'The collection of settings for a system or application, or the act of configuring them. Often shortened to "config."',
  mechanism_en = 'Different environments (development, production, etc.) typically have different configurations. Externalizing settings into files allows flexible operation.',
  analogy_en = 'Adjusting a car''s seat position and mirror angles. Same car, but each driver customizes the setup to their preference.',
  pitfall_en = 'Understand the difference between configuration and hard-coding. Values that might change belong in config files; constants that never change can stay in the code.'
WHERE term = 'Configuration' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'The combination of technologies used in a project',
  definition_en = 'The set of technologies—languages, frameworks, tools—used to build an application. For example: React + TypeScript + Tailwind CSS.',
  mechanism_en = 'Each layer of the application (frontend, backend, database, infrastructure) involves technology choices. The selection is driven by team expertise and project requirements.',
  analogy_en = 'A recipe and its matching set of kitchen tools. Just as Italian cooking has a go-to toolkit, building a web app has its own popular combinations.',
  pitfall_en = 'Packing too many trendy technologies into a stack adds unnecessary complexity. Start simple and add tools only as needed.'
WHERE term = 'Tech stack' AND chapter_id = 2;

UPDATE terms SET
  one_liner_en = 'A project''s instruction manual',
  definition_en = 'A documentation file describing a project''s overview, usage, and setup instructions. Usually written in Markdown format (README.md).',
  mechanism_en = 'On GitHub, a README is automatically displayed on the repository''s top page. It serves as the front door for anyone trying to understand the project.',
  analogy_en = 'The "Read This First" card included with a product. Reading it tells you what the project is and how to get started.',
  pitfall_en = 'Without a README, no one—including your future self—will be able to understand the project. Make it a habit to always write one, even if it feels tedious.'
WHERE term = 'README' AND chapter_id = 2;
