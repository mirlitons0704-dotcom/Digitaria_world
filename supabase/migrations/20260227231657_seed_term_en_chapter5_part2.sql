/*
  # Seed English translations for Chapter 5 terms (part 2 of 2)

  Translates the remaining 17 terms of Chapter 5 (terms 19–35).
  Topics: position, grid, overflow, viewport, responsive design,
  semantic HTML, ARIA, embed, iframe, containers, float, pseudo selectors.
*/

UPDATE terms SET
  one_liner_en = 'The property that controls how an element is positioned',
  definition_en = 'A CSS property that determines how an element is placed on the page. Combined with top, right, bottom, and left to specify location.',
  mechanism_en = 'Options include static (normal flow), relative (offset from normal), absolute (positioned within a containing block), fixed (stays in place during scroll), and sticky.',
  analogy_en = 'Furniture placement methods. "Follow the room''s layout (static)," "shift from the default spot (relative)," "place freely anywhere (absolute)."',
  pitfall_en = 'absolute doesn''t work as expected if the parent has position: static. Set the parent to relative first.'
WHERE term = 'Position' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A two-dimensional layout system for rows and columns',
  definition_en = 'A CSS layout method that places elements in a two-dimensional grid of rows and columns. Well-suited for complex page layouts.',
  mechanism_en = 'Set display: grid; on the parent, then define the grid with grid-template-columns and grid-template-rows.',
  analogy_en = 'A spreadsheet. Elements are freely placed in a grid of rows and columns.',
  pitfall_en = 'Grid is powerful, but for simple horizontal alignment, Flexbox is easier. Choose the right tool for the job.'
WHERE term = 'Grid' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'How to handle content that spills out of its box',
  definition_en = 'A CSS property that specifies what happens when an element''s content exceeds its box boundaries.',
  mechanism_en = 'visible (show the overflow), hidden (clip it), scroll (add scrollbars), auto (add scrollbars only when needed).',
  analogy_en = 'A glass of water overflowing. "Let it spill (visible)," "wipe it up (hidden)," "place a saucer underneath (scroll)."',
  pitfall_en = 'overflow: hidden also hides child elements that extend beyond the box, which can cause unexpected layout issues.'
WHERE term = 'Overflow' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'The visible area of the browser window',
  definition_en = 'The visible region of the browser window where a web page is displayed. Varies by device and screen size.',
  mechanism_en = 'Units like vw (viewport width) and vh (viewport height) let you size elements as a percentage of the screen.',
  analogy_en = 'The view through a window. The window (browser) size determines how much scenery (page) you can see.',
  pitfall_en = 'Mobile viewports need special attention. The <meta name="viewport"> tag is essential for proper rendering.'
WHERE term = 'Viewport' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A browser tool that simulates different screen sizes',
  definition_en = 'A feature in browser DevTools that lets you preview how a page looks on various screen sizes. No physical device needed.',
  mechanism_en = 'Open DevTools (F12), click the device toolbar, and select from devices like iPhone or Pixel to simulate their screen.',
  analogy_en = 'A fitting-room mirror. You can check how the outfit (layout) looks without actually going outside (using a real device).',
  pitfall_en = 'Simulations can differ from real devices. For critical checks, always test on actual hardware.'
WHERE term = 'Responsive mode' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A rule that switches styles based on conditions',
  definition_en = 'A mechanism that applies different CSS based on conditions like screen width. The core technology behind responsive design.',
  mechanism_en = '@media (max-width: 768px) { } defines styles for screens 768px wide or narrower. min-width, orientation, and more are available.',
  analogy_en = 'Dressing for the weather. "If the temperature is below 10 degrees (condition), wear a coat (style)."',
  pitfall_en = 'Choose breakpoint values based on real-world devices. Common ones include 768px and 1024px.'
WHERE term = 'Media query' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'Design for small screens first, then scale up',
  definition_en = 'An approach where the design starts with mobile (small screen) and progressively adds features and layout for larger screens.',
  mechanism_en = 'Write base CSS for mobile, then use min-width media queries to layer on styles for larger screens.',
  analogy_en = 'Packing light for a trip and adding gear as needed. More efficient than starting with a heavy suitcase.',
  pitfall_en = 'When retrofitting an existing desktop site for mobile, you may need the reverse approach (desktop-first).'
WHERE term = 'Mobile-first' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'HTML that uses meaningful, descriptive tags',
  definition_en = 'HTML that uses tags matching the meaning and role of the content—<header>, <nav>, <main>, <article>—instead of generic <div> tags everywhere.',
  mechanism_en = 'Choose tags that match the content''s purpose. This helps search engines and screen readers understand the page.',
  analogy_en = 'A book''s table of contents. "Prologue," "Chapter 1," "Summary"—the structure is immediately clear.',
  pitfall_en = '<div> and <span> carry no inherent meaning. Use them only for layout; use semantic tags for meaningful content.'
WHERE term = 'Semantic HTML' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'Attributes that convey information to screen readers',
  definition_en = 'Stands for Accessible Rich Internet Applications. A set of HTML attributes that provide extra information to assistive technologies like screen readers.',
  mechanism_en = 'Attributes such as aria-label, aria-hidden, and role add invisible information that assistive tools can read.',
  analogy_en = 'An audio guide for visually impaired visitors. "There is a button here," "this is a menu"—spoken descriptions added to the page.',
  pitfall_en = 'Overusing ARIA can be counterproductive. First use proper semantic HTML, then add ARIA only where needed.'
WHERE term = 'ARIA' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'HTML code for embedding external content',
  definition_en = 'HTML code that displays external content—YouTube videos, Google Maps, social media posts—inside your own site.',
  mechanism_en = 'Copy the "embed code" provided by the service and paste it into your HTML. Usually uses an iframe.',
  analogy_en = 'Pasting a magazine clipping into a scrapbook. You display another service''s content on your own site.',
  pitfall_en = 'Embedded content can slow down page load. Use it only where genuinely needed.'
WHERE term = 'Embed code' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'An element that displays another page inside a frame',
  definition_en = 'Stands for Inline Frame. An HTML element that embeds and displays a separate HTML page within the current page.',
  mechanism_en = '<iframe src="https://example.com"></iframe> renders the external page. Used for YouTube and Google Maps embeds.',
  analogy_en = 'Hanging a painting of another scene inside a room. You open a "window" to a different page within your page.',
  pitfall_en = 'Not all sites allow iframe embedding. X-Frame-Options headers can block it for security reasons.'
WHERE term = 'iFrame' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A parent element that groups child elements together',
  definition_en = 'A parent element that wraps and groups multiple child elements. Used for layout control and applying shared styles.',
  mechanism_en = '<div class="container">...</div> wraps related elements. Convenient for controlling width and centering content.',
  analogy_en = 'A cardboard box. You place multiple items (elements) into one box (container) for easy handling.',
  pitfall_en = 'Avoid nesting containers too deeply. Keep the structure as simple as possible.'
WHERE term = 'Container' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'An outer element that wraps other elements',
  definition_en = 'An outer element that encloses other elements. Often used interchangeably with "container."',
  mechanism_en = '<div class="wrapper">...</div> wraps child elements. Functionally the same as a container; naming is a convention.',
  analogy_en = 'Gift wrapping paper. It wraps the contents (child elements) to keep them together and looking neat.',
  pitfall_en = 'Whether to use "wrapper" or "container" depends on project conventions. Be consistent.'
WHERE term = 'Wrapper' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'An older layout technique that floats elements to one side',
  definition_en = 'A CSS property that pulls an element to the left or right, letting text wrap around it. Once used for column layouts.',
  mechanism_en = 'float: left; moves the element to the left. Subsequent elements wrap around it. clear cancels the wrapping.',
  analogy_en = 'A newspaper photo with text flowing around it. The image "floats" and the article text wraps alongside.',
  pitfall_en = 'Using float for layout is outdated. Use Flexbox or Grid instead. Float is still useful for text wrapping around images.'
WHERE term = 'Float' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'Cancels the wrapping effect of float',
  definition_en = 'A CSS property that stops elements from wrapping around floated elements.',
  mechanism_en = 'clear: both; cancels wrapping on both sides. clear: left; or clear: right; cancels one side only.',
  analogy_en = 'A divider that says "start a new section here." It cuts off the influence of the preceding floated elements.',
  pitfall_en = 'The "clearfix" hack was commonly used. Today, overflow: hidden or display: flow-root serve as alternatives.'
WHERE term = 'Clear' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A selector that targets an element''s state',
  definition_en = 'A selector that matches elements in a specific state—hovered, focused, first child, etc. Begins with a single colon (:).',
  mechanism_en = 'a:hover (on mouse hover), input:focus (when focused), li:first-child (the first child element), and more.',
  analogy_en = 'Adjectives describing a person''s state: "the person who is running," "the person who is sitting." You narrow the target by state.',
  pitfall_en = ':hover is awkward on mobile (requires a tap). Consider touch-friendly alternatives.'
WHERE term = 'Pseudo-class' AND chapter_id = 5;

UPDATE terms SET
  one_liner_en = 'A selector that targets part of an element',
  definition_en = 'A selector that targets a specific part of an element—its first letter, first line, or generated content before/after. Begins with double colons (::).',
  mechanism_en = 'p::first-letter (the first letter), div::before (content inserted before), div::after (content inserted after).',
  analogy_en = 'Highlighting part of a sentence. "Make only the first letter big" or "add a symbol after the text."',
  pitfall_en = '::before and ::after require the content property. Even an empty content: ""; must be specified.'
WHERE term = 'Pseudo-element' AND chapter_id = 5;
