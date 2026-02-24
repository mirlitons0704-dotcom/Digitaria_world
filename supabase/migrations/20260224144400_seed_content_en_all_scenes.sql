/*
  # Seed English story translations for all scenes (Chapters 1–17)

  Updates every row in story_scenes with an English translation in
  the new `content_en` column.  Rows are identified by
  (chapter_id, scene_number) so no hard-coded UUIDs are needed.
*/

-- =============================================
-- Chapter 1  (11 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'You opened your eyes and found yourself standing in an unknown place.\n\nLooking around, everything seemed to be made of "0"s and "1"s.\nThe clouds drifting across the sky, the ground beneath your feet, the mountains in the distance.\n\n"Where… am I?"\n\nThen, a tiny light appeared right in front of you.'
WHERE chapter_id = 1 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Hey! You''re awake!"\n\nThe light spoke. Looking closely, it was a small being flickering between 0 and 1.\n\n"I''m Bit. I''m a guide for this world called ''Digitaria''"\n\n"Digitaria…?"\n\n"That''s right! In your world, it''s called ''inside a computer.'' Here, everything is expressed in Binary—just 0s and 1s"\n\n"All of this, with just 0s and 1s?"\n\n"Hard to believe, right? But it''s true.\nThink of a light switch in your world.\nIt can only be ON or OFF—just two states, right?\nComputers work the same way. Either electricity is flowing, or it isn''t.\nWe represent that as 0 and 1"'
WHERE chapter_id = 1 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'As you began walking with Bit, a soft light danced through the air.\n\n"Oh… a butterfly?"\n\nLooking up, you saw several glowing butterflies flying above.\nTheir wings were made of particles of 0s and 1s, sparkling with every beat.\n\n"They''re beautiful…"\n\n"Those are ''Code Butterflies''"\nBit said happily.\n\n"They''re very important beings in this world.\nCode Butterflies carry the memories of knowledge"\n\n"They carry… the memories of knowledge?"\n\n"Yes. In Digitaria, there are many ''term flowers'' blooming. Code Butterflies fly from flower to flower, spreading meaning like pollination. That''s why the knowledge in this world isn''t scattered—it''s all connected"\n\nA butterfly gently landed on your fingertip.\nWhere its wings touched, you felt a faint warmth.\n\n"Wow…"\n\n"It seems to like you"\nBit smiled.\n\n"And there''s one more important thing.\nWhen you truly understand a term—\nnot just memorize it, but really feel ''I get it!''—\nthat knowledge becomes a particle of light, and a new butterfly is born"\n\n"When I learn, a butterfly…?"\n\n"Yes. At first, it''s just a tiny particle of light.\nBut as your understanding deepens, it becomes an egg, then a larva, then a chrysalis…\nand someday, it spreads its wings and flies like these beautiful butterflies"\n\nBit pointed into the distance.\nBeyond the hill, you could see countless lights dancing.\n\n"That''s the ''Memory Garden.''\nOnly those who have learned all 500 words can go there—it''s a special place"\n\n"500…"\n\n"That''s the number of terms you''ll learn on this journey.\nWhen you''ve understood every word, your butterflies will be dancing on that hill"\n\nThe glowing butterfly took off from your fingertip and disappeared into the sky with its companions.\n\nYou made up your mind.\nSomeday, you would visit that hill to see your own butterflies.'
WHERE chapter_id = 1 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'While walking, you spotted seven beings that looked just like Bit lined up in a row.\n\n"Oh, everyone! Let me introduce you.\nWhen eight of us Bits gather together, we become a ''Byte''"\n\nThe eight Bits lined up side by side, and with a flash of light, they merged into one larger being.\n\n"Hello. I am Byte"\n\nThe voice was gentle and calm.\n\n"When we become Byte, we can express so much more.\nFor example, one Byte can represent 256 different things!"\n\n"256 things…!"\n\n"That''s right. Numbers from 0 to 255, letters from ''A'' to ''Z''…\nWhen eight of us combine our power, what we can do expands enormously"'
WHERE chapter_id = 1 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'Byte showed you a mysterious chart.\n\n"This is called the ASCII code table.\nIt''s an agreement about which number represents which character, using one Byte"\n\nLooking at the chart, "65" was next to "A" and "66" was next to "B."\n\n"So when a computer sees the sequence ''01000001'' in 0s and 1s, it knows it means the letter ''A''?"\n\n"Exactly"\n\nBit bounced happily.\n\n"Isn''t it amazing! Depending on how we''re arranged, we can represent letters, numbers, and all sorts of things!"'
WHERE chapter_id = 1 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'After walking a bit more, you came across a strange signpost.\n\n"01001000 01000101 01001100 01001100 01001111"\n\n"What does this say?"\n\nBit explained:\n\n"That''s Machine language.\nIt''s the only language a computer can directly understand.\nThis sign says ''HELLO''"\n\n"''HELLO'' in just 0s and 1s…"\n\n"Long ago, humans would line up 0s and 1s like this to give instructions to computers. It must have been quite a challenge…"\n\n"That does sound really hard…"\n\n"That''s why humans came up with an easier way. That''s what ''Code'' is"'
WHERE chapter_id = 1 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'At the next spot, there were slightly more readable characters.\n\nprint("HELLO")\n\n"This is Code—an instruction written in a programming language"\n\n"Oh, I can almost read this one!"\n\n"Right? It''s a language made to be easy for humans to read and write.\nThere''s a mechanism that converts this into machine language that computers can understand"\n\n"Like a translator?"\n\n"Exactly! Just like a translator!\nIt bridges the gap between human language and machine language"'
WHERE chapter_id = 1 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'You arrived at a place where many sheets of paper with code were stacked up.\n\n"When lots of code comes together, it becomes a Program"\n\n"A program… like a sports day program?"\n\n"Great analogy!\nA sports day program lists things in order: ''opening ceremony → sprint race → ball toss → …''\nA computer program is the same—it''s a list of instructions in order: ''do this → then do this → …''"\n\n"So it''s like a to-do list!"\n\n"That''s right. A program is a ''to-do list'' for the computer"'
WHERE chapter_id = 1 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'Arriving in town, you saw various shops lined up.\n"Calculator Shop" "Notepad Shop" "Map Shop" "Camera Shop"…\n\n"These are all Apps.\nShort for Application—programs made for a specific purpose"\n\n"Like the apps on a smartphone?"\n\n"Exactly!\nA calculator app is for calculating, a camera app is for taking photos.\nPrograms with specific purposes are called apps"'
WHERE chapter_id = 1 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"By the way, are apps and software different?"\n\n"Great question!\nSoftware refers to all programs that run on a computer.\nApps are one type of software"\n\nBit drew a diagram.\n\n"In your world…\n''Software'' is like ''cooking'' in general, and ''apps'' are specific dishes like ''pasta'' or ''curry''"\n\n"So software is the bigger concept?"\n\n"Exactly!\nAnd the ''kitchen'' and ''frying pan'' used to cook are Hardware—the physical computer or smartphone itself"'
WHERE chapter_id = 1 AND scene_number = 10;

UPDATE story_scenes SET content_en = E'Finally, you were led to a library-like building.\nThe shelves were lined with many boxes.\n\n"These are Files.\nContainers for storing data"\n\n"Like a file folder for documents?"\n\n"Perfect analogy!\nFiles for text, files for photos, files for music…\nYou can organize and save data by type"\n\nYou opened one box and found neatly organized data inside.\n\n"In the next chapter, I''ll teach you more about the different types of files.\nThere are all kinds of extensions!"\n\n"Extensions?"\n\n"Hehe, look forward to it!"'
WHERE chapter_id = 1 AND scene_number = 11;

-- =============================================
-- Chapter 2  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Bit led you to a massive library. The gate read "File Kingdom Royal Library."\n\n"This library holds every kind of file in Digitaria"\n\nInside, the librarian Fila greeted you.\n\n"Welcome, traveler. In this library, we classify and store files by their ''extensions''"\n\n"Extensions—the part after the dot at the end of a file name?"\n\n"Exactly. By looking at the extension, you can tell what kind of data the file contains"'
WHERE chapter_id = 2 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'The first room had simple documents lined up.\n\n"This is the ''Text File'' room.\n.TXT is the simplest file format, storing only plain text without any formatting"\n\n"Like files made with Notepad!"\n\n"Yes. The great thing is that any computer can open them. However, you can''t make text bold or add colors"\n\nShe pointed to the next shelf, where some unusual files sat.\n\n"These are .MD—Markdown format. They''re text files, but you can use simple symbols to create headings and bullet points"\n\n"It''s a very popular format among programmers"'
WHERE chapter_id = 2 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'The next room was colorful and lively.\n\n"This is the ''Web Files'' room"\n\nFila showed three files.\n\n"An .HTML file creates the ''skeleton'' of a web page. Think of it as the blueprint that determines where the walls and pillars go in a house"\n\n".CSS handles the ''decoration.'' Wallpaper colors, furniture placement, curtain patterns—it makes everything look beautiful"\n\n"And .JS (JavaScript) adds ''movement.'' Open a door and the lights turn on, press a button and music plays—it creates those kinds of mechanisms"\n\n"So the three of them share the work!"\n\n"Wonderful understanding. And .TS (TypeScript) is an improved version of JavaScript that lets you write code more safely"'
WHERE chapter_id = 2 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The next room had neatly arranged boxes.\n\n"This is the ''Data Formats'' room.\n.JSON is a popular format for organizing and storing data"\n\nFila showed the contents.\n\n"It''s readable by humans and easy for computers to understand. A format that''s friendly to both"\n\n".CSV is a format for storing tabular data. It''s commonly used in business since it can be opened in Excel"\n\n"It''s very simple—just values separated by commas"'
WHERE chapter_id = 2 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"This is the ''Image Files'' room"\n\nThe walls were decorated with many pictures.\n\n".JPG (JPEG) is a format for photographs. It can make file sizes small, but the quality degrades slightly each time you save"\n\n".PNG can preserve transparent areas. It''s often used for logos and icons, and the quality doesn''t degrade"\n\n".SVG is special. No matter how much you zoom in, it never gets blurry. That''s because it represents shapes using mathematical formulas"\n\n"It never gets blurry when you zoom in? That''s like magic!"\n\n"It''s perfect for icons and logos"'
WHERE chapter_id = 2 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'Beyond a heavy door was a room of business documents.\n\n".PDF is a format that looks the same on any computer. It''s used for contracts and reports"\n\n"It''s also hard to edit, which is actually a feature. It''s convenient when you want to share ''finished documents''"\n\nFila showed some small files.\n\n"These are configuration files"\n\n".YAML is a format for writing settings in a human-readable way"\n\n".env is a file for storing secret information like passwords. You must never show it to anyone"\n\n"There are secret files too…"'
WHERE chapter_id = 2 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"This room is for more advanced users"\n\nFila continued.\n\n".JSX and .TSX are special formats used with a tool called React. You can write HTML-like code inside JavaScript"\n\n".SCSS is a format for writing CSS more conveniently. You can use variables, nest styles… it''s very useful for large projects"\n\n".SQL is a language for sending commands to a database. You use it when you want to ask ''give me data matching these conditions''"\n\n"There are so many different types…"'
WHERE chapter_id = 2 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Files also contain ''invisible information,'' you know"\n\nFila handed you a mysterious magnifying glass. Looking through it at a file, you could see hidden text.\n\n"This is Metadata—''data about data''"\n\n"Creation date, modification date, file size, author''s name… Think of it like the colophon in a book"\n\n"So there''s all sorts of information recorded behind the scenes that you normally can''t see!"'
WHERE chapter_id = 2 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"To manage a project, Config files are essential"\n\n"Configuration is gathered into a single file so that everyone on the team can work in the same environment"\n\n"And README—the project''s instruction manual. It''s a very important file that says ''please read this first''"\n\n"When looking at a new project, always read the README first. That''s the basic rule"'
WHERE chapter_id = 2 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'Before leaving the library, Fila gave one final explanation.\n\n"The combination of technologies used to build an app is called a Tech stack"\n\n"For example, React + TypeScript + Tailwind CSS is a very popular tech stack"\n\n"Once you understand data Formats and choose the right tech stack, you''ll be able to build all kinds of apps"\n\n"Thank you, Fila!"\n\n"Come back anytime. Next, a journey awaits where you''ll learn about data ''types''"'
WHERE chapter_id = 2 AND scene_number = 10;

-- =============================================
-- Chapter 3  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'After leaving the library, a white building came into view. A sign read "Data Structure Research Institute."\n\n"This is where they research how to organize data," said Bit.\n\nOpening the door, a person in a lab coat greeted you.\n\n"Welcome! I''m Dr. Struct. I research beautiful ways to organize data"\n\n"Organize data…?"\n\n"Yes. Data has ''types.'' Is it text? A number? True or false? If you know the type, you can handle data correctly"'
WHERE chapter_id = 3 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'The first room had several shelves.\n\n"First, let me introduce Primitive—the basic data types"\n\n"String is a sequence of characters. Things like \\"Hello\\" or \\"こんにちは.\\" Always enclosed in quotation marks"\n\n"Number handles numerical values. Numbers like 42 or 3.14. Integer refers specifically to whole numbers"\n\n"Boolean has only two values: true or false. It''s used for ''yes'' or ''no'' answers"\n\n"Simple, but these are the fundamentals"'
WHERE chapter_id = 3 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"What''s fascinating is that ''nothing'' can also be expressed as a data type"\n\nThe doctor showed an empty box.\n\n"Null means ''intentionally nothing.'' The box is prepared, but you deliberately left it empty"\n\n"Undefined means ''not yet defined.'' You forgot to prepare the box in the first place"\n\n"Both mean ''nothing,'' but they have different meanings…"\n\n"Understanding this difference makes it much easier to find the cause of errors"'
WHERE chapter_id = 3 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The next room was full of boxes and labels.\n\n"A Variable is a box for storing data. You can change its contents later"\n\n"A Constant is a box that, once filled, cannot be changed. It''s used for values that should always stay the same"\n\n"Use a variable for things that might change, and a constant for things that never should. Knowing when to use which is important"'
WHERE chapter_id = 3 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'A long shelf had numbered drawers lined up.\n\n"An Array is a structure where data of the same kind is arranged in order"\n\n"The drawer number is called an Index. In programming, we start counting from 0"\n\n"Counting from 0?"\n\n"Yes, this is a common point of confusion. The first element is not number 1—it''s number 0"'
WHERE chapter_id = 3 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'Another room had labeled shelves.\n\n"An Object is a structure that groups related data together. It''s organized using Key-value pairs"\n\n"Name, age, occupation… You can manage all the information about one ''person'' together"\n\n"This is the concept of a Record. Each individual item is called a Field"'
WHERE chapter_id = 3 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are even more useful data structures"\n\nThe doctor explained while drawing diagrams.\n\n"A Set is a collection with no duplicates. Even if you add the same thing twice, only one remains"\n\n"A Map efficiently manages key-value pairs. It''s also called a Hash"\n\n"A Tuple is a fixed-length array where the order matters. Like coordinates (x, y)"\n\n"Each one has different strengths…"'
WHERE chapter_id = 3 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"For large projects, we create ''blueprints'' for data"\n\nThe doctor wrote on a whiteboard.\n\n"A Schema is a blueprint for data structure. It defines what fields exist and what type each one is"\n\n"An Interface defines the shape of an object. It''s a contract that says ''follow this shape''"\n\n"A Type alias gives another name to a type. A Union type allows multiple possible types"'
WHERE chapter_id = 3 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"An Enum (enumeration type) is a type that only allows a fixed set of choices"\n\n"Traffic lights can only be red, green, or yellow, right? You can restrict values so nothing else can be entered"\n\n"So it prevents wrong data"\n\n"Exactly! A type system is a safety mechanism that prevents mistakes before they happen"'
WHERE chapter_id = 3 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'Deep inside the institute, there were three-dimensional models.\n\n"These are more advanced, but let me introduce them"\n\n"A Stack is like stacking books. You take out the last thing you put in first"\n\n"A Queue is like a line at a cashier. The first person in line is served first"\n\n"A Tree is a hierarchical structure, like a family tree"\n\n"A Graph is a connection structure, like a train route map"\n\n"A Vector is data with direction and magnitude. It''s used in games to move characters"\n\n"There are so many kinds of data structures…!"'
WHERE chapter_id = 3 AND scene_number = 10;

-- =============================================
-- Chapter 4  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'"Now, it''s time for real programming training!"\n\nYou passed through the gate of an old-fashioned dojo with Bit.\n\n"Welcome to the Programming Dojo"\n\nA woman in training clothes greeted you. Her name was Loop.\n\n"Here, you will learn the ''etiquette'' of code. With proper etiquette, you can give precise instructions to computers"'
WHERE chapter_id = 4 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"First, let''s start with Syntax"\n\nLoop wrote with a brush.\n\n"Syntax is the grammar of a programming language. Just as human language has grammar rules, programs have rules for how to write them"\n\n"A Statement is a single instruction. An Expression is a part that produces a value"\n\n"An Operator is a symbol like +, -, ×, ÷. It performs calculations or comparisons"\n\n"= is Assignment. It means ''put the value on the right into the variable on the left''"'
WHERE chapter_id = 4 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Let me teach you programming''s special move: the Function"\n\n"A function bundles instructions and gives them a name. Once created, you can call it as many times as you like"\n\n"A Parameter is the ''receiving slot'' you set up when creating a function"\n\n"An Argument is the ''actual value'' you pass when using a function"\n\n"A Return value is the result a function gives back"\n\n"A Method is a function that belongs to an object"'
WHERE chapter_id = 4 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Scope is the range where a variable is visible"\n\nLoop drew a diagram.\n\n"Global scope is the range visible from the entire program"\n\n"Local scope is the range visible only inside a function"\n\n"Block scope is the range visible only inside { }"\n\n"Closure is a mechanism where a function remembers variables from its outer scope. It''s a bit tricky, but very useful"'
WHERE chapter_id = 4 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Here''s my specialty: the Loop!"\n\nLoop demonstrated enthusiastically.\n\n"You don''t have to write the same thing over and over. That''s the power of loops"\n\n"An Iteration is one pass through a loop. If you loop 5 times, that''s 5 iterations"'
WHERE chapter_id = 4 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Conditionals are also an important technique"\n\n"If/else is the most basic conditional. ''If this, then do this; otherwise, do that…''"\n\n"A Switch statement is convenient when choosing from multiple options"\n\n"With conditionals, a program can behave differently depending on the situation"'
WHERE chapter_id = 4 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"For conditionals, the concepts of Truthy and Falsy are important"\n\n"Truthy values are treated as ''true'' in conditions. Falsy values are treated as ''false''"\n\n"Comparison operators like ===, !==, <, > compare values"\n\n"Logical operators: && (and), || (or), ! (not)"'
WHERE chapter_id = 4 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Let''s also learn string manipulation techniques"\n\n"Concatenation means joining strings together"\n\n"But nowadays, Interpolation is more convenient. Wrap text in backticks and put variables inside ${}"\n\n"It''s easier to read and reduces mistakes"'
WHERE chapter_id = 4 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Errors are a natural part of programming. But there are ways to deal with them"\n\n"A Comment is a note you leave in your code. It doesn''t get executed, so you can write explanations"\n\n"Debug means finding and fixing bugs (defects)"\n\n"A Breakpoint is a marker that pauses the program. You can stop it and examine what''s inside"\n\n"An Exception is when an unexpected error occurs. Error handling lets you deal with it safely"'
WHERE chapter_id = 4 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"Finally, here are the principles of writing good code"\n\nLoop unrolled a scroll.\n\n"Readability—write code that others can understand too"\n\n"Modularity—divide by function so it''s easy to reuse"\n\n"Hierarchy—keep things organized with clear structure"\n\n"Granularity—each function should do only one job"\n\n"Write Instructions line by line and practice Feature-aware code"\n\n"Avoid Inline coding—properly separate logic into functions"\n\n"Follow these principles and you''ll write code with fewer bugs that''s easier to maintain"'
WHERE chapter_id = 4 AND scene_number = 10;

-- =============================================
-- Chapter 5  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the dojo, you arrived at a bustling construction site. Buildings were being constructed everywhere.\n\n"This is the Web Page Construction Site!"\n\nA pair of twins approached.\n\n"Hi! I''m HTML"\n"And I''m CSS"\n\n"Together, we build ''houses'' called web pages"\n\n"HTML handles the structure—the pillars and walls"\n"CSS handles the interior—the colors and layout"\n\n"The two of us together is what makes a great house"'
WHERE chapter_id = 5 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'HTML showed you a blueprint.\n\n"HTML uses Tags to create structure"\n\n"Things wrapped in < > are tags. They follow the pattern <opening tag>content</closing tag>"\n\n"An Element is the whole thing—tag plus its contents"\n\n"An Attribute adds extra information to a tag"\n\n"The DOM (Document Object Model) represents HTML as a tree structure. It''s used when JavaScript manipulates the page"'
WHERE chapter_id = 5 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"You can give names to elements," said CSS.\n\n"A Class is for giving the same name to multiple elements"\n\n"An ID is a unique name given to just one element"\n\n"A Selector is how you choose which elements to apply styles to"\n\n"You specify styles with a Property and a Value"'
WHERE chapter_id = 5 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"There are three ways to write Styles"\n\n"A Stylesheet is putting CSS in a separate file. That''s the most recommended way"\n\n"Inline style is writing it directly on the tag. Only use it in emergencies"\n\n"Well-organized stylesheets are the key to a maintainable site"'
WHERE chapter_id = 5 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Every element is a ''box''"\n\nCSS drew a diagram.\n\n"If you understand the Box model, you''ll understand layout"\n\n"Margin is the space outside the element"\n"Padding is the space inside the element"\n"Border is the element''s frame"\n\n"Adjust these three and you can achieve any layout you want"'
WHERE chapter_id = 5 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Display and Position determine how things are placed," said HTML.\n\n"display: block stacks elements vertically"\n"display: inline arranges them horizontally"\n"display: none hides them"\n\n"position: relative adjusts from the original position"\n"position: absolute places freely based on the parent"\n"position: fixed keeps it fixed on the screen"\n\n"Overflow is a property that controls what happens when content doesn''t fit in its box. Use hidden to clip the overflow, or scroll to make it scrollable"'
WHERE chapter_id = 5 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Nowadays, Flexbox and Grid are the mainstream"\n\n"Grid is great for two-dimensional layouts. It''s used for complex page compositions"\n\n"Float used to be common, but Grid is more convenient now. If you do use Float, don''t forget to Clear it"'
WHERE chapter_id = 5 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"You want it to look good on both phones and desktops, right?"\n\n"Viewport is the visible area of the browser"\n\n"You use Media queries for that"\n\n"Mobile-first means designing for phones first, then expanding for larger screens"\n\n"Responsive mode is a browser feature that simulates different screen sizes"'
WHERE chapter_id = 5 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Practice Semantic HTML," said HTML.\n\n"Instead of using <div> for everything, use tags that convey meaning"\n\n"Accessibility—aim for a site everyone can use"\n\n"ARIA attributes convey information to screen readers used by visually impaired people"'
WHERE chapter_id = 5 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"You can also embed content from other sites"\n\n"An iFrame displays another page inside a frame"\n\n"Embed code is code for pasting things like YouTube videos or Google Maps into your site"\n\n"Container and Wrapper are boxes that group elements together. They''re used to organize layout"\n\n"A Pseudo-class like :hover represents a state"\n\n"A Pseudo-element like ::before decorates part of an element"'
WHERE chapter_id = 5 AND scene_number = 10;

-- =============================================
-- Chapter 6  (7 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Past the construction site, a large port spread before you.\n\n"This is the gateway to the Internet Sea"\n\nA man standing by a ship waved.\n\n"Hey there! I''m Captain Router. I help ships cross this sea and connect to servers all around the world"\n\n"The Internet is a vast network connecting computers all over the world"'
WHERE chapter_id = 6 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"First, let me teach you about URLs"\n\nThe captain spread out a map.\n\n"A URL is a Uniform Resource Locator—an address on the Internet"\n\n"A Domain is an easy-to-remember name like example.com"\n\n"A Subdomain is the part before the domain, like www"\n\n"The actual computers have numerical addresses called IP addresses"\n\n"DNS is like a phone book that converts domain names into IP addresses"'
WHERE chapter_id = 6 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Link is a bridge connecting page to page"\n\n"Also called a Hyperlink. Click it and you jump to another page"\n\n"In HTML, you create them using the Anchor tag <a>"\n\n"The Href attribute specifies the destination URL"\n\n"A Path parameter is a value in the URL path, like /users/123"\n\n"A Query string is information added after ?, like ?name=test&age=20"\n\n"A Query parameter is each individual pair like name=test within the query string"'
WHERE chapter_id = 6 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Just as ships follow rules when entering port, the Internet has Protocols"\n\n"HTTP is the protocol for fetching web pages"\n\n"HTTPS adds encryption to HTTP. It uses SSL/TLS technology for secure communication"\n\n"A Port is like a ''window number'' for communication. HTTP uses port 80, HTTPS uses port 443"\n\n"If you see the padlock icon 🔒, that means the site is communicating securely via HTTPS"'
WHERE chapter_id = 6 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Communication works through an exchange of Requests and Responses"\n\nThe captain drew a diagram.\n\n"The browser sends a ''request'' to the server, and the server sends back a ''response.'' The web runs on this back-and-forth"\n\n"Ingress is incoming traffic, and Egress is outgoing traffic"'
WHERE chapter_id = 6 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Server responses come with a Status code"\n\n"200 OK means ''Success! No problems''"\n\n"400 Bad Request means ''Your request was incorrect''"\n\n"401 Unauthorized means ''You need to log in''"\n\n"403 Forbidden means ''You don''t have permission''"\n\n"404 Not Found means ''The page you''re looking for doesn''t exist''"\n\n"500 Internal Server Error means ''Something went wrong on the server''"\n\n"These three-digit numbers instantly tell you what happened"'
WHERE chapter_id = 6 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are protocols for purposes other than HTTP too"\n\n"RSS is a system for distributing blog updates. You can check the latest posts from your favorite sites all in one place"\n\n"SMTP is the protocol for sending email"\n\n"Each protocol is used according to its specific role"'
WHERE chapter_id = 6 AND scene_number = 7;

-- =============================================
-- Chapter 7  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the port, you reached a dojo on top of a mountain. A gate read "JavaScript Dojo."\n\n"This is where you''ll learn to bring movement to the Web," said Bit.\n\nA white-haired master greeted you.\n\n"Welcome. I am JS Master. I shall teach you the secrets of JavaScript"\n\n"JavaScript is a language that breathes life into web pages. It makes things happen when you click a button"\n\n"TypeScript is an improved version of JavaScript that adds ''types.'' It lets you write code more safely"'
WHERE chapter_id = 7 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"ES6 was a major update to JavaScript that came out in 2015"\n\n"ECMAScript is the official name for JavaScript. ES6 is technically ECMAScript 2015"\n\n"Let and Const are ways to declare variables"\n\n"An Arrow function is a new, shorter way to write functions"\n\n"The => symbol looks like an arrow, doesn''t it?"'
WHERE chapter_id = 7 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"On the Web, there''s a lot of ''waiting.'' You can''t have things freeze while fetching data"\n\n"A Promise is a mechanism that ''promises a future result''"\n\n"Async/Await makes Promises easier to read"\n\n"Fetch is the technique for retrieving data from a server"\n\n"Then/catch is the traditional way of handling Promises"'
WHERE chapter_id = 7 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Let me teach you some handy syntax added in ES6"\n\n"The Spread operator expands arrays and objects"\n\n"Destructuring extracts values from arrays and objects"\n\n"Master these and your code will become much shorter"'
WHERE chapter_id = 7 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Large programs are divided into Modules"\n\n"Import brings things in from other files"\n"Export makes things available to other files"\n\n"Default export publishes one main thing from a file"\n\n"Named export publishes multiple features with names"\n\n"Barrel exports re-export multiple modules from one place"\n\n"Library import lets you use convenient external libraries"'
WHERE chapter_id = 7 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"An Event is a notification that something happened"\n\n"Clicks, key presses, scrolling… every user action becomes an event"\n\n"An Event listener is a watchman that monitors events"\n\n"An Event handler is the code that runs when an event occurs"\n\n"Prevent default stops the browser''s built-in behavior"\n\n"The This keyword refers to the current object. It changes depending on context, so be careful"'
WHERE chapter_id = 7 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are also techniques for controlling time"\n\n"setTimeout runs something once after a specified delay"\n\n"setInterval runs something repeatedly at a specified interval"\n\n"You can make clocks tick on web pages or fetch data periodically"'
WHERE chapter_id = 7 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Let me teach you powerful array manipulation techniques"\n\n"Map function transforms every element and creates a new array"\n\n"Filter function extracts only elements that match a condition"\n\n"Reduce function combines all elements into a single value"\n\n"ForEach runs a process on every element"\n"Find returns the first element matching a condition"\n\n"Combine these and you can write complex data processing concisely"'
WHERE chapter_id = 7 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Console log is the absolute basics of debugging"\n\n"Get retrieves a value, Typeof checks the type"\n\n"Parsing means analyzing a string and converting it into data"\n\n"Zod is a library for validating data shapes in TypeScript"\n\n"A Utility is a handy helper function"'
WHERE chapter_id = 7 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"JavaScript can run not just in browsers, but also on servers"\n\n"Node.js is an environment for running JavaScript on servers"\n\n"Thanks to this, you can write both frontend and backend in JavaScript"\n\n"In the next chapter, you''ll learn React. You''ll be able to build more complex UIs using your JavaScript knowledge"\n\n"Thank you, Master!"'
WHERE chapter_id = 7 AND scene_number = 10;

-- =============================================
-- Chapter 8  (9 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Coming down the mountain, you saw a modern school building.\n\n"Welcome to Component Academy!"\n\nA young woman teacher greeted you.\n\n"I''m React Sensei. I teach React—a UI construction library"\n\n"React was created by Facebook and is very popular. Its specialty is building UIs by dividing them into ''parts''"\n\n"A React component is one of those ''parts.'' You combine small parts to build a large screen"'
WHERE chapter_id = 8 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Functional components are the current standard"\n\n"JSX is a syntax that lets you write HTML-like code inside JavaScript"\n\n"TSX is the TypeScript version of JSX"\n\n"It looks like HTML, but it''s actually JavaScript"\n\n"Use className instead of class—that''s a JSX rule"'
WHERE chapter_id = 8 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Props are the way to pass data from parent to child"\n\n"Children prop is a special Prop that passes the content between tags"\n\n"State is changeable data that a component owns"\n\n"Local state is data only for that component, and Global state is data shared across the entire app"'
WHERE chapter_id = 8 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"A Hook is magic that adds features to functional components"\n\n"useState is the Hook for using State"\n\n"useEffect handles Side effects—data fetching, subscriptions, and more"\n\n"The Dependency array determines when useEffect runs"\n\n"useRef holds a value. It''s also used for references to DOM elements"\n\n"useMemo and useCallback are Memoization hooks. They prevent unnecessary recalculations"'
WHERE chapter_id = 8 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Components have a Lifecycle"\n\n"Mount is when a component appears on screen"\n\n"Unmount is when it disappears"\n\n"Render is when a component draws the screen"\n\n"Re-render happens when State or Props change and it redraws"\n\n"Virtual DOM is the secret to React''s speed. Instead of touching the real DOM directly, it calculates differences on a virtual copy"\n\n"Only the parts that changed get updated, making it very efficient"'
WHERE chapter_id = 8 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Conditional rendering changes what''s displayed based on conditions"\n\n"List rendering displays array data repeatedly"\n\n"A Key prop is a unique identifier for each item in a list"\n\n"Without it, React can''t tell which elements have changed"\n\n"A Fragment lets you group elements without adding extra nodes to the DOM"'
WHERE chapter_id = 8 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"As an app grows, State management becomes important"\n\n"Prop drilling is the problem of passing Props through many layers like a bucket brigade"\n\n"One solution is Context"\n\n"Context is a mechanism to share data without using Props"\n\n"A Context provider supplies data, and useContext receives it"\n\n"A Reducer and useReducer manage complex state changes in one place"\n\n"A State store is a centralized place to manage state"\n\n"Lifting state means moving State to a common parent component"'
WHERE chapter_id = 8 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"A Custom hook is an original hook you create yourself"\n\n"The beauty of custom hooks is that they let you reuse logic"\n\n"Hook names must always start with use. That''s a React rule"'
WHERE chapter_id = 8 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"A Controlled component manages form element values with State"\n\n"React has full control over the input values. It makes validation and such much easier"\n\n"Now you''ve mastered the basics of React!"\n\n"Next, let''s go learn about UI component patterns"'
WHERE chapter_id = 8 AND scene_number = 9;

-- =============================================
-- Chapter 9  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the academy, you spotted a workshop filled with colorful parts.\n\n"This is the UI Parts Workshop!"\n\nA stylish woman greeted you.\n\n"I''m Mia, the UI Designer. I''ll teach you how to make user-friendly parts"\n\n"A Page is the whole screen, and a Component is a part within it"\n\n"A Header is the top of a page, and a Footer is the bottom"\n\n"A Navbar is a navigation menu, and a Sidebar is an auxiliary menu on the side"\n\n"Layout is the arrangement pattern of these elements. Navigation is the system for moving between pages"'
WHERE chapter_id = 9 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"A Card is a box that displays information together"\n\nMia showed some samples.\n\n"Social media posts, product listings, profile displays… cards are used everywhere"\n\n"A Button is a part you click to make something happen"\n\n"It''s important that the design makes it obvious it''s clickable"'
WHERE chapter_id = 9 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Form is where users enter information"\n\n"An Input field is the box where you type text"\n\n"A Label is the text that tells you what to enter"\n\n"A Placeholder is a faint hint shown inside the input field"\n\n"Validation checks whether the input is correct"\n\n"An Error message is a warning shown when there''s a problem with the input"\n\n"Submit sends the form''s contents. It triggers when you press the submit button"'
WHERE chapter_id = 9 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"There are all sorts of selection parts too"\n\n"A Checkbox is a square button that lets you select multiple options"\n\n"A Radio button is a round button that lets you select just one"\n\n"A Select is a part that lets you choose from a dropdown"\n\n"A Dropdown menu is a list of options that opens when clicked"\n\n"A Toggle is a switch for turning things ON or OFF"\n\n"A Slider is a part where you drag a handle to select a value"'
WHERE chapter_id = 9 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Parts that communicate to users are also important"\n\n"An Alert is a display that highlights important notices"\n\n"A Notification tells users about new information"\n\n"A Toast is a brief notice that pops up in the corner and disappears automatically"\n\n"Imagine bread popping out of a toaster"\n\n"A Tooltip is a small explanation that appears when you hover over something"'
WHERE chapter_id = 9 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"A Modal is a window displayed on top of the screen"\n\n"It''s also called a Dialog box. It''s used for confirmation messages and input forms"\n\n"A Popup is similar but usually smaller"\n\n"An Overlay darkens the background to make the modal stand out"\n\n"Clicking the overlay to close the modal is a common pattern"'
WHERE chapter_id = 9 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"You shouldn''t leave users waiting with nothing to look at while data loads"\n\n"A Spinner is a spinning loading indicator"\n\n"A Progress bar shows how far along something is"\n\n"A Skeleton loader is a gray placeholder shaped like the content"\n\n"Since you can imagine what will appear, the wait feels shorter"'
WHERE chapter_id = 9 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Let me also introduce parts for organizing information"\n\n"An Accordion is a collapsible section that opens and closes on click"\n\n"It''s commonly used for FAQs"\n\n"Tabs let you switch content in the same space"\n\n"Pagination divides content across multiple pages and provides navigation"'
WHERE chapter_id = 9 AND scene_number = 8;

-- =============================================
-- Chapter 10  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the workshop, you saw a white marble building.\n\n"This is the ''Design Museum''"\nMia guided you in.\n\n"In this chapter, we''ll learn about UI/UX"\n\n"UI is User Interface—the screens and parts that users interact with"\n\n"UX is User Experience—the overall experience a user feels"\n\n"Both visual beauty (UI) and ease of use (UX) are important"'
WHERE chapter_id = 10 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'The first gallery had design plans on display.\n\n"A Wireframe is a blueprint showing only the skeleton of a page"\n\n"You leave out colors and design and focus only on placement"\n\n"A Mockup is a design close to the finished product, with colors and fonts"\n\n"The typical flow is: wireframe → mockup → implementation"'
WHERE chapter_id = 10 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Design system is a set of organized design rules"\n\n"Colors, fonts, spacing, button styles… keeping everything consistent maintains brand coherence"\n\n"A Component library is a collection of reusable parts"\n\n"Design tokens define colors and sizes as variables"\n\n"A Theme is the overall feel of a design"\n\n"Light mode has a bright background, Dark mode has a dark one. These days, offering both is the norm"'
WHERE chapter_id = 10 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The next gallery was filled with rainbow-like colors.\n\n"A Color scheme is the color plan for the entire site"\n\n"Hex color starts with # followed by 6 alphanumeric characters"\n\n"RGB represents colors using three values: red, green, and blue"\n\n"Opacity is transparency. 0 is fully transparent, 1 is fully opaque"'
WHERE chapter_id = 10 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Typography is the field of designing text"\n\n"A Font is a typeface"\n\n"Font family specifies which font to use"\n\n"Font size is the text size, Font weight is the thickness"\n\n"Line height is the height of a line. Around 1.5 to 1.8 is easy to read"\n\n"Google Fonts is a treasure trove of free fonts. They''re easy to use on websites"'
WHERE chapter_id = 10 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"An Icon is a small picture that conveys meaning"\n\n"Lucide dev icons is a popular icon library"\n\n"A Favicon is the small icon displayed in a browser tab"\n\n"Pexels is a free stock photo site for commercial use"\n\n"The More options icon (⋮ or …) opens a menu"\n\n"Home refers to the site''s top page"\n\n"A QR code is a square code that, when scanned with a phone, takes you to a URL"'
WHERE chapter_id = 10 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Parts have various ''states''"\n\n"Hover state is how it looks when the mouse is over it"\n\n"Active state is how it looks while being clicked"\n\n"Focus state is how it looks when selected by keyboard. Very important for accessibility"\n\n"Disabled state is how it looks when it can''t be interacted with. Usually grayed out"'
WHERE chapter_id = 10 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Here are decoration techniques that enrich design"\n\n"Drop shadow adds a shadow to make an element look like it''s floating"\n\n"Border radius rounds the corners"\n\n"A Gradient is an effect where colors gradually change"\n\n"Combining these creates a sense of depth and dimension"'
WHERE chapter_id = 10 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Animations add movement to elements"\n\n"A Transition creates smooth changes between states"\n\n"When you hover, the color smoothly changes—that kind of pleasant movement"\n\n"But don''t overdo it. Too much motion is tiring, and some people get motion sick"\n\n"Animations are like spices. The right amount is what matters"'
WHERE chapter_id = 10 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"Finally, some basic layout terms"\n\n"A Row is a horizontal line, and a Column is a vertical line"\n\n"In a grid system, you combine rows and columns to create layouts"\n\n"You''ve learned the basics of design. Next, let''s learn how to style efficiently using CSS frameworks"'
WHERE chapter_id = 10 AND scene_number = 10;

-- =============================================
-- Chapter 11  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the museum, you saw a stylish tailor''s shop.\n\n"Welcome! I''m the Tail Craftsman. I''ll teach you techniques for writing CSS efficiently"\n\n"CSS is very flexible, but that makes it hard to manage in large projects"\n\n"That''s where CSS frameworks and various styling methods come in"'
WHERE chapter_id = 11 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Tailwind is the most popular CSS framework right now"\n\n"It''s based on a Utility-first philosophy"\n\n"You combine small classes to build styles"\n\n"You can style everything right in the HTML without writing separate CSS files"\n\n"Once you get the hang of it, you can develop at blazing speed!"'
WHERE chapter_id = 11 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Shadcn is a beautiful component collection based on Tailwind"\n\n"You can copy and paste them, and customize them however you like"\n\n"CSS-in-JS is a technique of writing CSS inside JavaScript"\n\n"CSS modules isolate CSS on a per-component basis"'
WHERE chapter_id = 11 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Sass and SCSS are languages that extend CSS"\n\n"Variables, nesting, mixins… features CSS doesn''t have"\n\n"Being able to write nested styles makes the structure much clearer, doesn''t it?"\n\n"However, browsers can''t read SCSS directly, so it needs to be compiled into CSS"'
WHERE chapter_id = 11 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"CSS variables are a variable feature built into CSS itself"\n\n"Also called Custom properties"\n\n"Define them with names starting with -- and use them with var()"\n\n"They''re great for theme switching. Just change the variable values and the entire site''s colors change"'
WHERE chapter_id = 11 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"The scope of styles is also important"\n\n"Global styles are styles applied across the entire site"\n\n"Scoped styles are styles applied only to a specific component"\n\n"Without proper scoping, styles can leak into unintended places"\n\n"That''s why it''s important to keep styles contained within their component"'
WHERE chapter_id = 11 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Browsers have default styles. But they vary slightly between browsers"\n\n"Reset CSS is an approach that zeros out all default styles"\n\n"Normalize CSS is an approach that evens out browser differences while keeping useful defaults"\n\n"Which one you use is a matter of preference, but some countermeasure is needed"'
WHERE chapter_id = 11 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"PostCSS is a tool for transforming and optimizing CSS"\n\n"You can combine plugins to perform various processes"\n\n"Autoprefixer automatically adds vendor prefixes for browser compatibility"\n\n"It handles old browser support automatically, saving developers a lot of work"'
WHERE chapter_id = 11 AND scene_number = 8;

-- =============================================
-- Chapter 12  (7 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the tailor''s shop, you saw a cave halfway up the mountain.\n\nAn old man with a long white beard stood at the entrance.\n\n"Welcome to the Terminal Cave. I am the Terminal Elder"\n\n"In this cave, I shall teach you how to use the black screen—the terminal"\n\n"Beginners fear the black screen, but once mastered, it becomes the most powerful weapon"'
WHERE chapter_id = 12 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Let''s start with the development environment"\n\n"An IDE is an Integrated Development Environment"\n\n"It''s a tool that combines everything—writing code, running it, debugging…"\n\n"A Code editor is an editor for writing code. Visual Studio Code is popular"\n\n"An IDE is feature-rich; a code editor is simple and lightweight. Each has its strengths"\n\n"A Sandbox is an isolated environment where you can safely try out code without affecting production"'
WHERE chapter_id = 12 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Now, let''s talk about the black screen"\n\n"A Terminal is the screen where you type commands"\n\n"It''s also called the Command line or CLI"\n\n"A Shell is the program that interprets and executes commands"\n\n"Bash is one of the most common shells"\n\n"Sometimes commands are faster than clicking with a mouse"'
WHERE chapter_id = 12 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"There are also modern terminals these days"\n\n"Warp is a modern, user-friendly terminal app"\n\n"AI suggests commands and organizes output into blocks"\n\n"You can even use Warp as a Coding agent—it helps fix and generate code"\n\n"The era of coding alongside AI has arrived"'
WHERE chapter_id = 12 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Browsers also have powerful tools"\n\n"Dev tools are development support features built into browsers"\n\n"Open them with F12 or by right-clicking and choosing Inspect"\n\n"The Console panel shows JavaScript logs and errors"\n\n"The Network panel lets you see communication details"\n\n"The Network log makes it easy to see exactly what requests are being sent"'
WHERE chapter_id = 12 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"A Debugger is a tool that pauses program execution so you can inspect its state"\n\n"A Call stack records the order in which functions were called"\n\n"A Stack trace displays the call history when an error occurs"\n\n"Read it from bottom to top to see what triggered the error"'
WHERE chapter_id = 12 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"When a page is acting up, first try a Refresh"\n\n"If that doesn''t work, try a Hard refresh—a complete reload that ignores the cache"\n\n"Taking a Screenshot to record the error state is also important"\n\n"An Error is a message indicating a problem in the program"\n\n"A Crash is when a program stops completely"\n\n"A Network error occurs when there''s a communication problem"'
WHERE chapter_id = 12 AND scene_number = 7;

-- =============================================
-- Chapter 13  (7 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Emerging from the cave, you found a huge distribution center. Trucks were coming and going.\n\n"Hey! I''m a Package Courier. I deliver useful packages to developers all around the world"\n\n"A Package is a bundle of useful code someone else wrote. Instead of building everything from scratch, using packages saves you time"'
WHERE chapter_id = 13 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"npm stands for Node Package Manager. It''s a package management tool for JavaScript"\n\n"An npm package is a package distributed through npm"\n\n"npm install is the command to download packages"\n\n"npm run is the command to execute scripts"\n\n"npx runs a package temporarily without installing it"'
WHERE chapter_id = 13 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Yarn is also a popular package manager"\n\n"It does the same things as npm, but the commands are slightly different"\n\n"Which one to use is decided by the team, but functionally they''re almost the same"\n\n"Packages is the plural form—it refers to the many packages used in a project"'
WHERE chapter_id = 13 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"A Dependency is a package your project needs"\n\n"If your project uses React, then React is a dependency"\n\n"A Dev dependency is a package needed only during development"\n\n"Testing tools and code formatting tools fall into this category"'
WHERE chapter_id = 13 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Package.json is a project''s configuration file"\n\n"It lists which packages are used, what scripts are available, and more"\n\n"Package-lock.json is a type of Lock file. It pins exact versions"\n\n"Node modules is the folder containing installed packages"'
WHERE chapter_id = 13 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Semantic versioning is a set of rules for numbering versions"\n\n"1.2.3—Major.Minor.Patch"\n\n"Major is a big change (not backward-compatible), Minor adds features (backward-compatible), Patch is a bug fix"\n\n"If you don''t pin versions, you might end up with ''it worked yesterday but not today!''"'
WHERE chapter_id = 13 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Development has multiple ''environments''"\n\n"A Development environment is where developers write and test code"\n\n"A Staging environment is a near-production environment for testing"\n\n"A Preview environment is a temporary environment for reviewing changes"\n\n"A Production environment is the live environment users actually use"\n\n"An Environment variable is a way to pass different settings for each environment"'
WHERE chapter_id = 13 AND scene_number = 7;

-- =============================================
-- Chapter 14  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the distribution center, you found an old-fashioned library. But inside, countless glowing lines floated like timelines.\n\n"Welcome to the Library of Time. I am the Git Librarian"\n\n"Here, I shall teach you how to record and manage the ''history'' of code"\n\n"Git is a version control system—a tool for recording and managing the history of code changes"'
WHERE chapter_id = 14 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"A Repository is a project''s vault. It contains the code and its entire history"\n\n"GitHub is a service for sharing and managing repositories online"\n\n"Clone means copying a repository to your own computer"\n\n"Fork means copying someone else''s repository to your own account"\n\n"Cloning is like ''borrowing''; forking is like ''making it your own''"'
WHERE chapter_id = 14 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Branch is a ''fork in the road'' of development"\n\nYou could see glowing lines branching out.\n\n"The Main branch is the main river—the production code"\n\n"A Feature branch is a branch for developing new features"\n\n"You branch off to develop, then merge back into the main river when done"\n\n"Checkout means switching between branches"'
WHERE chapter_id = 14 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"A Commit is the act of recording a change"\n\n"Think of it as creating a save point"\n\n"The Staging area is the ''preparation zone'' before committing"\n\n"You use git add to stage changes, then git commit to finalize them"\n\n"Write a concise commit message describing what you changed"'
WHERE chapter_id = 14 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Commit, Push, and Pull are the basic flow of Git"\n\n"Push sends your local changes to the remote (GitHub)"\n\n"Pull brings remote changes to your local machine"\n\n"When working in a team: Pull to get the latest, work and Commit, then Push"'
WHERE chapter_id = 14 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Merge combines branches together"\n\n"A Merge conflict happens when the same spot was edited separately on different branches"\n\n"You need to resolve it manually by choosing which version to keep"\n\n"Rebase is an alternative merge method that moves the starting point of a branch"'
WHERE chapter_id = 14 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are other useful commands too"\n\n"Stash temporarily saves your in-progress changes"\n\n"Reset undoes a commit"\n\n"Revert creates a new commit that undoes a previous one"\n\n"Diff shows the changes between versions"\n\n".gitignore specifies which files Git should not track"'
WHERE chapter_id = 14 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"A Pull request is a ''request'' to merge your changes into the main branch"\n\n"You create it on GitHub"\n\n"Code review is when others check your code"\n\n"Once approved, it gets merged"\n\n"GitHub Actions automatically runs tests or deployments triggered by pushes or pull requests"'
WHERE chapter_id = 14 AND scene_number = 8;

-- =============================================
-- Chapter 15  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the Library of Time, a grand castle stood before you.\n\n"Welcome to the Server Castle!"\n\nA knight in armor greeted you.\n\n"I am the Server Guardian. I protect this castle—the Backend"\n\n"The Backend, or Back end, handles the processing that users don''t see"\n\n"A Server is a computer that receives requests and processes them"\n\n"Server side refers to the processing that happens on the server"'
WHERE chapter_id = 15 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Let me explain the two sides"\n\n"Frontend / Front end is the side users directly interact with—the screen"\n\n"Client side is the processing that runs in the user''s browser"\n\n"Full stack refers to a developer who can do both"'
WHERE chapter_id = 15 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"The castle has many rooms. Deciding which room to lead visitors to is the job of a Route"\n\n"Routes are multiple routes. They''re also called Endpoints"\n\n"A Router directs requests to the appropriate route"\n\n"Route security protects routes so only authenticated users can access them"'
WHERE chapter_id = 15 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Let me explain how a request is processed"\n\n"A Controller is the command center that receives requests and directs processing"\n\n"A Service handles the Business logic—the actual processing"\n\n"A Model defines the shape of data and communicates with the database"\n\n"A Handler is a function responsible for a specific task"'
WHERE chapter_id = 15 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Middleware is processing that sits between the request and response"\n\n"It handles authentication checks, logging, data transformation, and more"\n\n"Think of it as a security guard checking IDs at the entrance"'
WHERE chapter_id = 15 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"REST is an API design style"\n\n"RESTful means following the principles of REST"\n\n"Stateless means the server doesn''t remember the client''s state"\n\n"Every time, you include the necessary information in the request"\n\n"A Session temporarily stores a user''s state"\n\n"A Cookie is a small piece of data stored in the browser. It''s used to maintain login state"'
WHERE chapter_id = 15 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Let''s look at the structure of a request"\n\n"A Header contains supplementary information for the request"\n\n"The Body is the main content—the data being sent"\n\n"Payload is used with the same meaning as Body"'
WHERE chapter_id = 15 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"HTTP methods indicate what you want to do"\n\n"GET means ''I want to retrieve data''"\n"POST means ''I want to create something new''"\n"PUT means ''I want to update something''"\n\n"Using these correctly is the foundation of RESTful API design"\n\n"In the next chapter, we''ll dive deeper into APIs"'
WHERE chapter_id = 15 AND scene_number = 8;

-- =============================================
-- Chapter 16  (9 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the Server Castle, you came upon a grand building with flags from all over the world flying.\n\n"This is the API Embassy. I am the API Ambassador"\n\n"API stands for Application Programming Interface—it''s the ''window'' through which software talks to other software"\n\n"Just as an embassy connects countries, APIs connect apps"'
WHERE chapter_id = 16 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"An API call is a request made to an API"\n\n"An API endpoint is the specific URL of an API"\n\n"An API key is a key that proves you have permission to use the API"\n\n"Without this key, you can''t use the API"\n\n"API keys are secret! Never expose them publicly"'
WHERE chapter_id = 16 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"CRUD represents the four basic data operations"\n\n"C - Create → POST\nR - Read → GET\nU - Update → PUT\nD - Delete → DELETE"\n\n"You express these through HTTP methods"\n\n"DELETE is the method for removing data"\n\n"A REST API is an API design style that uses these methods"'
WHERE chapter_id = 16 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"GraphQL is a different API format from REST"\n\n"With a Query, you specify exactly what data you want to retrieve"\n\n"With a Mutation, you modify data"\n\n"REST has fixed data for each URL, but GraphQL lets the client choose what data it needs"'
WHERE chapter_id = 16 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"A WebSocket is a communication method where the server and client stay constantly connected"\n\n"A Socket is the connection point"\n\n"It enables Real-time data exchange"\n\n"It''s used where instant updates are needed, like chat apps and stock tickers"\n\n"A Real-time Subscription automatically receives data changes. It''s commonly used with GraphQL"'
WHERE chapter_id = 16 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"A Webhook is a system that automatically sends a notification when an event occurs"\n\n"For example, you register: ''When payment is complete, notify this URL''"\n\n"A Callback is a function that gets called when a process finishes"\n\n"A Callback ID identifies which callback it is"\n\n"Invocation means calling a function or API"'
WHERE chapter_id = 16 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"APIs have various limitations"\n\n"A Rate limit is a cap on the number of requests allowed in a time period"\n\n"Throttling limits or delays requests"\n\n"Debouncing processes only the last of a series of rapid events"\n\n"A Timeout cuts off processing when there''s no response within a certain time"'
WHERE chapter_id = 16 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"CORS stands for Cross-Origin Resource Sharing—a mechanism that controls data sharing between different domains"\n\n"For security, access from different domains is blocked by default"\n\n"The server needs to explicitly allow it"\n\n"An SDK is a Software Development Kit—a toolkit that makes it easier to use an API"\n\n"With an SDK, learning to use an API becomes much easier"'
WHERE chapter_id = 16 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'The API Ambassador smiled.\n\n"With this, the journey through 500 terms comes to an end"\n\nBit jumped with joy.\n\n"We did it! You learned them all!"\n\n"You can now understand the language of the programming world"\n\n"But this isn''t the end—it''s the beginning"\n\n"Use this knowledge to actually write code and build apps"\n\n"The words you learned on this journey will surely help you along the way"'
WHERE chapter_id = 16 AND scene_number = 9;

-- =============================================
-- Chapter 17: Epilogue – Memory Garden  (13 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'After leaving Chapter 16—the API Embassy—you found yourself in a place you''d never seen before.\n\nA field of flowers stretched out in every direction. But the petals were made of light, each one gently flickering.\n\nAnd overhead—countless butterflies were dancing across the sky.\n\n"This is…"\n\n"The Memory Garden"\n\nA familiar voice. You turned around to find Bit and Byte.\n\n"You learned 500 words"\n"That''s why you were able to come here"\n\n"These butterflies are…"\n"The Code Butterflies born each time you learned"\n\n500 butterflies danced around you in celebration.'
WHERE chapter_id = 17 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'Then, a butterfly landed on your hand.\n\n"The journey ends here, but…"\n"The butterflies have a gift for you"\n\n"A gift?"\n\n"When you actually start writing code, there are important words you''re sure to encounter"\n\n"Twenty words we couldn''t cover in the main story, but that we want you to know"\n\nThe butterflies began to descend, one by one.'
WHERE chapter_id = 17 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'The first butterfly softly began to glow.\n\n"Programs sometimes fail"\n\n"But with Try/catch, you''ll be okay"\n\n"You try in the try block and catch the failure in catch"\n\n"Don''t be afraid of failure. As long as you''re prepared to handle it, you can take the leap"\n\nThe next butterfly descended.\n\n"Even ''nothing'' has different types"\n\n"null means ''intentionally empty''"\n\n"undefined means ''nothing has been put in yet''"\n\n"They seem similar, but the meanings differ. Knowing this makes finding bugs much easier"'
WHERE chapter_id = 17 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The third butterfly glowed gently.\n\n"When accessing deep objects, you''ll get an error if something in the middle is null"\n\n"But with ?. (Optional chaining), it''s safe"\n\n"Think of it like politely knocking and asking ''are you there?'' as you go"\n\nThe fourth butterfly followed.\n\n"Nullish coalescing is the ?? operator that provides a fallback when the value is null or undefined"\n\nThe fifth.\n\n"A Template literal uses backticks to embed variables in strings"\n\nThe sixth.\n\n"The Ternary operator is condition ? when true : when false—a shorthand for if-else"'
WHERE chapter_id = 17 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'The seventh butterfly glowed warmly.\n\n"Want to save data in the browser? You can use localStorage"\n\n"localStorage is a mechanism for storing data in the browser"\n\n"It persists even after closing the browser. Great for saving theme settings or favorites"\n\n"But it can only store strings, so convert objects to JSON first"'
WHERE chapter_id = 17 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'The eighth, ninth, tenth, and eleventh butterflies descended together.\n\n"Let me teach you about CSS layout"\n\n"Flexbox is a layout for arranging elements in a row"\n\n"Grid is powerful for two-dimensional layouts. You can place elements in rows and columns like spreadsheet cells"\n\n"z-index determines which element appears in front when they overlap. The higher the number, the closer to the front"\n\n"The Box model—every element is made of four layers: content, padding, border, and margin"'
WHERE chapter_id = 17 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'The twelfth and thirteenth butterflies descended together.\n\n"You want things to look good on phones and PCs—that''s Responsive design"\n\n"It adapts the layout to the screen size"\n\n"A Breakpoint (CSS) is the boundary where the layout changes"\n\n"Starting with small screens—''Mobile first''—is recommended"'
WHERE chapter_id = 17 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'The fourteenth butterfly settled quietly.\n\n"HTTP responses come back with a number"\n\n"Status code—200 is OK, 404 is not found, 500 is server error"\n\n"4xx means ''your side has a problem,'' 5xx means ''the server has a problem''"\n\n"With these numbers, you can tell what happened"'
WHERE chapter_id = 17 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'The fifteenth, sixteenth, seventeenth, and eighteenth butterflies descended in succession.\n\n"Let''s get your creation out to the world"\n\n"Deploy means publishing your app. You put your code on a server so anyone can access it"\n\n"Hosting means renting a place to publish your site. Vercel, Netlify, AWS… there are many services"\n\n"A Domain is the address of a site, like example.com"\n\n"SSL / HTTPS encrypts communication. Sites that start with https:// have encrypted traffic. These days, HTTPS is a must"'
WHERE chapter_id = 17 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'The nineteenth butterfly rested on your shoulder.\n\n"SEO—Search Engine Optimization"\n\n"You want to appear near the top when someone searches on Google, right?"\n\n"Title, description, page structure, loading speed… there are many ways to make your site more discoverable"\n\n"But the most important thing is to create great content"'
WHERE chapter_id = 17 AND scene_number = 10;

UPDATE story_scenes SET content_en = E'And then—the last butterfly descended. The 500th butterfly. It was noticeably large and shone beautifully.\n\n"Accessibility is the consideration that makes things usable by everyone"\n\n"People with low vision, people who are hard of hearing, people who can''t use a mouse… making sure everyone can enjoy what you create"\n\n"This isn''t something you add at the end—it''s something you keep in mind from the start"\n\nThe butterfly spoke gently.\n\n"Building for everyone. That''s what truly beautiful code is"'
WHERE chapter_id = 17 AND scene_number = 11;

UPDATE story_scenes SET content_en = E'Twenty butterflies danced around you. Then, all 500 butterflies soared high into the sky.\n\nA vortex of light enveloped the entire garden.\n\n"You learned 520 words"\n\nBit smiled brightly.\n\n"But this isn''t the end"\n\nByte continued.\n\n"Just knowing the words doesn''t mean you can speak the language yet"\n\n"You have to actually write code, fail, and write again…"\n\n"Only then do the words become ''power''"\n\n"But you''re not afraid anymore, right?"\n"Because you know the words"\n"Because you know where to start"\n\n"We''ll always be with you"\n\n"Goodbye, traveler"\n"And—"\n"Welcome back, engineer"'
WHERE chapter_id = 17 AND scene_number = 12;

UPDATE story_scenes SET content_en = E'When the light faded—you found yourself sitting in front of your own computer.\n\nOn the screen was an empty editor. And a blinking cursor.\n\nGlancing out the window—just for a moment, you thought you saw a glowing butterfly.\n\nNo, you definitely saw one.\n\nYou smiled and placed your hands on the keyboard.\n\nYou typed the first line into the editor.\n\nconst greeting = "Hello, World!";\nconsole.log(greeting);\n\nYou pressed the run button.\n\n    Hello, World!\n\nThe moment the text appeared on screen—you felt a tiny butterfly take flight in your heart.\n\n"Now then, what shall I build?"\n\nWith 520 words and 520 butterflies, your true journey begins.'
WHERE chapter_id = 17 AND scene_number = 13;
