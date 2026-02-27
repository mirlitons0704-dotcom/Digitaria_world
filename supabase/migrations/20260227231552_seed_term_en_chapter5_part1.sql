/*
  # Seed English translations for Chapter 5 terms (part 1 of 2)

  Translates the first 18 terms of Chapter 5.
  Topics: HTML/CSS fundamentals, DOM, elements, selectors, box model.
*/

UPDATE terms SET
  one_liner_en = 'The language that builds the structure of a web page',
  definition_en = 'Stands for HyperText Markup Language. A language for describing the structure of web pages. Elements like headings, paragraphs, links, and images are expressed by wrapping content in "tags."',
  mechanism_en = 'Tags such as <html>, <body>, <h1>, and <p> define the document structure. A browser reads the file and renders it as a web page.',
  analogy_en = 'A building blueprint that marks "this is a pillar," "this is a wall," "this is a door." HTML marks "this is a heading," "this is a paragraph," "this is a link."',
  pitfall_en = 'HTML alone looks plain. You need CSS for colors and layout. Think of HTML as the "skeleton" and CSS as the "interior design."'
WHERE term = 'HTML' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The language that styles the appearance of a web page',
  definition_en = 'Stands for Cascading Style Sheets. A language for specifying the visual look—colors, sizes, layout—of structures built with HTML.',
  mechanism_en = 'A selector picks the target, then properties and values define styles. Example: h1 { color: blue; } means "make h1 tags blue."',
  analogy_en = 'Interior design for a house. Choosing wallpaper colors, furniture placement, lighting brightness—all without changing the structure (HTML).',
  pitfall_en = 'The "C" in CSS stands for "Cascading," meaning later-declared styles override earlier ones. Without understanding this rule, debugging gets confusing.'
WHERE term = 'CSS' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A tree-structured representation of an HTML page',
  definition_en = 'Stands for Document Object Model. A representation of an HTML document as a tree of objects. Used by JavaScript to interact with and manipulate the page.',
  mechanism_en = 'html branches into head and body, which branch into div, p, h1, and so on in parent-child relationships. Access nodes via document.getElementById() and similar methods.',
  analogy_en = 'A family tree. html is the ancestor, and body, div, and p are descendants branching out from it.',
  pitfall_en = 'DOM manipulation is "expensive." Frequent updates slow down the page. This is one reason frameworks like React use a virtual DOM.'
WHERE term = 'DOM' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A single building block of HTML',
  definition_en = 'The combination of an opening tag, content, and a closing tag. For example, <p>This is a paragraph</p> is one element.',
  mechanism_en = 'Elements can be nested inside each other. <div><p>text</p></div> places one element inside another.',
  analogy_en = 'A single LEGO brick. You snap bricks (elements) together to build a larger creation (a page).',
  pitfall_en = '"Tag" and "element" are often confused. A tag is the <p> or </p> symbol; an element is the tag plus everything inside it.'
WHERE term = 'Element' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The angle-bracket symbols that mark up HTML',
  definition_en = 'An HTML instruction enclosed in < >. Content is wrapped between an opening tag <p> and a closing tag </p> to create an element.',
  mechanism_en = 'The basic pattern is <tagname>content</tagname>. Some tags like <img> and <br> are "void elements" with no closing tag.',
  analogy_en = 'Bookmarks in a book. They mark "heading starts here" and "heading ends here."',
  pitfall_en = 'Forgetting to close a tag can break the layout. Make it a habit: every tag you open, you close.'
WHERE term = 'Tag' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'Extra information attached to a tag',
  definition_en = 'Additional information added to a tag, written as name="value" inside the opening tag.',
  mechanism_en = 'In <a href="https://example.com">Link</a>, href is the attribute. Other common attributes include id, class, src, and alt.',
  analogy_en = 'A product label. You stick extra info—"color: red," "size: L"—onto the product (tag).',
  pitfall_en = 'It''s easy to forget the = between the attribute name and value, or the quotes around the value. Write them carefully.'
WHERE term = 'Attribute' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'An attribute that groups elements under a shared name',
  definition_en = 'An attribute that assigns a group name to elements. Multiple elements with the same class can be styled together.',
  mechanism_en = '<div class="card">...</div> assigns the card class. In CSS, .card { } targets all elements with that class. Multiple classes can be applied.',
  analogy_en = 'A homeroom class in school. You can address "all students in Class 1" as a single group.',
  pitfall_en = 'Note the difference: HTML uses class, while JSX (React) uses className.'
WHERE term = 'Class' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A unique identifier for a single element',
  definition_en = 'An attribute that uniquely identifies one element on a page. The same ID can only be used once per page.',
  mechanism_en = '<div id="main-header">...</div> assigns the ID. In CSS, #main-header { } targets it.',
  analogy_en = 'An employee ID number. Within a company (page), each person (element) gets exactly one unique number.',
  pitfall_en = 'Using the same ID on multiple elements violates the HTML spec and causes bugs, even if it seems to work.'
WHERE term = 'ID' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A pattern that picks which elements to style',
  definition_en = 'The CSS notation for choosing which elements to apply styles to. Elements can be selected by tag name, class, ID, attributes, and more.',
  mechanism_en = 'div { } selects by tag; .card { } by class; #header { } by ID. Selectors can be combined.',
  analogy_en = 'Picking people out of a crowd by criteria: "the person in the red hat," "the person wearing glasses."',
  pitfall_en = 'Complex selectors make it hard to tell which element is affected. Keep them simple.'
WHERE term = 'Selector' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The aspect of styling you want to change',
  definition_en = 'A CSS declaration specifying which visual aspect to modify: color, font-size, margin, and so on.',
  mechanism_en = 'Used as selector { property: value; }. Example: h1 { color: blue; font-size: 24px; }',
  analogy_en = 'The label on a control knob: "volume," "brightness," "hue"—telling you what gets adjusted.',
  pitfall_en = 'CSS property names use hyphens (font-size). In JavaScript, they switch to camelCase (fontSize).'
WHERE term = 'Property' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The specific setting for a property',
  definition_en = 'The concrete setting assigned to a CSS property. Depending on the property, it can be a color name, number, keyword, etc.',
  mechanism_en = 'In color: blue;, "blue" is the value. In font-size: 16px;, "16px" is the value. In display: flex;, "flex" is the value.',
  analogy_en = 'The number you dial on a control knob. Set the volume to "7" or the brightness to "max."',
  pitfall_en = 'Forgetting the unit (px, em, rem, %) can make a declaration ineffective. Always pair numbers with the right unit.'
WHERE term = 'Value' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The visual appearance settings of an element',
  definition_en = 'All settings related to an element''s visual presentation—color, size, font, spacing, and layout.',
  mechanism_en = 'Defined in CSS or directly via an HTML style attribute: style="color: red;".',
  analogy_en = 'Putting together an outfit. Combining color, shape, and material to create a look.',
  pitfall_en = 'Inline style attributes are convenient but hurt maintainability. Avoid overusing them.'
WHERE term = 'Style' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A file that collects all style definitions',
  definition_en = 'An external .css file containing CSS style definitions. Can be shared across multiple HTML pages.',
  mechanism_en = 'Loaded into HTML with <link rel="stylesheet" href="style.css">. Centralizes styling for the entire site.',
  analogy_en = 'A dress-code handbook. "Suits for meetings," "casual Fridays"—a single reference for all the rules.',
  pitfall_en = 'If the file path is wrong, styles won''t load. Double-check the path.'
WHERE term = 'Stylesheet' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'Styles written directly on a tag',
  definition_en = 'CSS written directly in an HTML tag''s style attribute. Applies only to that specific element.',
  mechanism_en = '<p style="color: red; font-size: 16px;">Text</p> — declared as an attribute.',
  analogy_en = 'A quick on-the-spot clothing fix. Handy in a pinch, but not organized for the long run.',
  pitfall_en = 'Cannot be reused and clutters the HTML. Avoid except for emergencies or dynamic JS-driven changes.'
WHERE term = 'Inline style' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'Spacing outside an element',
  definition_en = 'The space created outside an element. Used to control the gap between neighboring elements.',
  mechanism_en = 'margin: 10px; sets 10px on all sides. margin: 10px 20px; sets 10px top/bottom and 20px left/right. Individual sides can also be set.',
  analogy_en = 'Personal space between people. It keeps a comfortable distance from other elements.',
  pitfall_en = 'Watch out for margin collapse: when vertical margins overlap, only the larger one is applied.'
WHERE term = 'Margin' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'Spacing inside an element',
  definition_en = 'The space between an element''s content and its border. Background color extends into the padding area.',
  mechanism_en = 'padding: 10px; sets 10px on all sides. Syntax mirrors margin.',
  analogy_en = 'Packing material inside a shipping box. The internal cushioning that protects the contents.',
  pitfall_en = 'Adding padding increases the element''s total size (under box-sizing: content-box). Use border-box to avoid this.'
WHERE term = 'Padding' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The visible outline around an element',
  definition_en = 'A line drawn around an element. You can control its width, style, and color.',
  mechanism_en = 'border: 1px solid black; draws a 1px solid black line. border-radius rounds the corners.',
  analogy_en = 'A picture frame. It surrounds the content and adds a finishing touch.',
  pitfall_en = 'Borders also contribute to the element''s total size (under box-sizing: content-box). Factor them into layout calculations.'
WHERE term = 'Border' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The property that controls how an element is shown',
  definition_en = 'A CSS property that determines how an element is rendered and participates in layout.',
  mechanism_en = 'block stacks vertically; inline flows horizontally; none hides the element; flex enables flexbox; grid enables grid layout.',
  analogy_en = 'How products are displayed in a store. "Stack vertically on a shelf (block)," "line up in a row (inline)," "put away in the stockroom (none)."',
  pitfall_en = 'display: none removes the element from the layout entirely. visibility: hidden hides it but preserves its space.'
WHERE term = 'Display' AND chapter_id = 5;
