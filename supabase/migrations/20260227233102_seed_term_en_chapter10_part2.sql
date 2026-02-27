/*
  # Seed English translations for Chapter 10 terms (Part 2: terms 21-40)
  
  Continues Chapter 10 UI/UX Design concepts.
  Updates the remaining 20 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'The vertical space a line of text occupies',
  definition_en = 'A property controlling the height of each line of text, which directly affects the spacing between lines and overall readability.',
  mechanism_en = 'Set with line-height: 1.5; to make lines 1.5 times the font size. Body text is typically most readable between 1.5 and 1.8.',
  analogy_en = 'The ruled lines on writing paper. Too tight and text feels cramped; too loose and it feels disconnected.',
  pitfall_en = 'Using a unitless number (like 1.5) makes it a multiplier of the font size, which is the recommended approach.'
WHERE term = 'Line height' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A free library of web fonts',
  definition_en = 'A free web font library provided by Google, offering over 1,000 fonts that can be easily added to any website.',
  mechanism_en = 'Load fonts via a <link> tag or @import in CSS, then reference them in font-family declarations.',
  analogy_en = 'A free typeface catalog. Browse and pick any font, then use it on your site at no cost.',
  pitfall_en = 'Loading too many fonts slows down page rendering. Only import the specific weights and styles you actually need.'
WHERE term = 'Google Fonts' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A small symbol that conveys meaning',
  definition_en = 'A small image or symbol that visually represents a function or concept. Icons communicate meaning more quickly than text alone.',
  mechanism_en = 'Implemented as SVGs, icon fonts, or images. Popular libraries include Lucide and Font Awesome.',
  analogy_en = 'Road signs. You understand the meaning at a glance without reading any text.',
  pitfall_en = 'Icons alone can be ambiguous. Pairing them with text labels ensures the meaning is clear for all users.'
WHERE term = 'Icon' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'An open-source icon library',
  definition_en = 'An open-source icon library forked from Feather Icons, offering over 1,000 clean, consistent line-art icons.',
  mechanism_en = 'Install lucide-react and import icons directly: import { Home } from ''lucide-react'';',
  analogy_en = 'A unified set of pictograms. Every icon shares the same style, so they always look harmonious together.',
  pitfall_en = 'Keep icon sizes and stroke widths consistent throughout your app. Mixing sizes breaks visual unity.'
WHERE term = 'Lucide dev icons' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'The small icon in a browser tab',
  definition_en = 'A tiny icon displayed in the browser tab and bookmarks bar that helps users identify a website at a glance.',
  mechanism_en = 'Set in HTML with <link rel="icon" href="/favicon.ico">. Providing multiple sizes improves display across different contexts.',
  analogy_en = 'A shop''s signboard logo. Even at a small size, it instantly identifies the brand.',
  pitfall_en = 'Favicons are very small, so complex designs become unrecognizable. Keep the icon simple and bold.'
WHERE term = 'Favicon' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'How an element looks when the mouse is over it',
  definition_en = 'The visual change that occurs when a mouse cursor hovers over an interactive element — signaling that the element is clickable or actionable.',
  mechanism_en = 'Defined in CSS with the :hover pseudo-class. For example: button:hover { background: blue; }.',
  analogy_en = 'Reaching for a door handle. It signals "you can open this" before you actually push.',
  pitfall_en = 'Touch devices don''t have hover. Make sure tap interactions provide equivalent visual feedback.'
WHERE term = 'Hover state' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'How an element looks while being clicked',
  definition_en = 'The visual state of an element during the moment it is being clicked or tapped. It provides immediate feedback that the action registered.',
  mechanism_en = 'Defined with the :active pseudo-class. Common effects include slightly shrinking the element or darkening its color.',
  analogy_en = 'Pressing an elevator button. It lights up or depresses to confirm you pressed it.',
  pitfall_en = ':active only applies during the click itself. Since it''s brief, make the visual change obvious enough to notice.'
WHERE term = 'Active state' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'How an element looks when selected via keyboard',
  definition_en = 'The visual state of an element when it receives keyboard focus (e.g., via the Tab key). Essential for keyboard-only users to know where they are on the page.',
  mechanism_en = 'Defined with the :focus pseudo-class. Typically shown as an outline or highlighted background around the focused element.',
  analogy_en = 'Pointing at a blank on a form. It shows "this is the field I''m currently filling in."',
  pitfall_en = 'Never remove focus outlines (outline: none) without providing an alternative style. It breaks keyboard accessibility.'
WHERE term = 'Focus state' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'How an element looks when it can''t be used',
  definition_en = 'The visual state of a button or form element that is temporarily non-interactive. Usually grayed out to indicate it cannot be clicked.',
  mechanism_en = 'Set with the disabled HTML attribute. Styled with :disabled in CSS. Adding cursor: not-allowed; reinforces the message.',
  analogy_en = 'An out-of-order vending machine. Its appearance clearly signals "not available right now."',
  pitfall_en = 'Always communicate why an element is disabled. A tooltip or message explaining the reason helps users understand what to do.'
WHERE term = 'Disabled state' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A shadow behind an element for depth',
  definition_en = 'A visual effect that places a shadow behind an element, creating the illusion of depth and elevation.',
  mechanism_en = 'Set with box-shadow: 0 4px 6px rgba(0,0,0,0.1);. Parameters control offset, blur radius, and color.',
  analogy_en = 'Sunlight casting a shadow beneath an object. The shadow makes it look like the object is floating above the surface.',
  pitfall_en = 'Heavy, dark shadows look dated. Modern design favors subtle, soft shadows for a refined look.'
WHERE term = 'Drop shadow' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'Rounded corners on an element',
  definition_en = 'A CSS property that rounds the corners of an element. Higher values create rounder corners, giving a softer appearance.',
  mechanism_en = 'Set with border-radius: 8px; to round all corners. Use 50% to create a perfect circle. Individual corners can be set separately.',
  analogy_en = 'A table with rounded edges. Sharp corners feel rigid; rounded ones feel softer and friendlier.',
  pitfall_en = 'Keep border-radius values consistent across your app. Use design tokens to manage them for visual harmony.'
WHERE term = 'Border radius' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A smooth color transition effect',
  definition_en = 'A visual effect where one color gradually blends into another. Used on backgrounds and buttons to add depth or visual interest.',
  mechanism_en = 'Set with background: linear-gradient(to right, red, blue); for a horizontal blend. radial-gradient() creates circular blends.',
  analogy_en = 'A sunset sky. Colors shift smoothly from orange to red to deep purple across the horizon.',
  pitfall_en = 'Bold, flashy gradients can be overwhelming. Keep them subtle or use similar hues for a refined effect.'
WHERE term = 'Gradient' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'Visual effects that change over time',
  definition_en = 'Visual effects that alter an element''s appearance over time. Used for loading indicators, page transitions, and interactive feedback.',
  mechanism_en = 'Defined with CSS @keyframes or controlled via JavaScript. Libraries like Framer Motion simplify complex animations in React.',
  analogy_en = 'A flipbook. Slightly different drawings shown in rapid sequence create the illusion of movement.',
  pitfall_en = 'Excessive animation hurts performance and can be distracting. Respect the prefers-reduced-motion user setting.'
WHERE term = 'Animations' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A smooth shift between states',
  definition_en = 'An effect that makes property changes happen gradually instead of instantly — like a button color smoothly fading to a new shade on hover.',
  mechanism_en = 'Set with transition: all 0.3s ease; to animate changes over 0.3 seconds. You specify which properties, duration, and easing curve.',
  analogy_en = 'A light fading in. Instead of switching on abruptly, the brightness increases smoothly.',
  pitfall_en = 'Using "all" is convenient but transitions every property. For better performance, specify only the properties you want to animate.'
WHERE term = 'Transition' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A free stock photo and video website',
  definition_en = 'A stock media service offering high-quality photos and videos for free, including for commercial use.',
  mechanism_en = 'Search and download from the website directly. An API is also available for programmatic access to the media library.',
  analogy_en = 'A free photo library. Borrow any image you need and use it in your projects.',
  pitfall_en = 'Be mindful of portrait rights when using photos of people. Always check the license terms before use.'
WHERE term = 'Pexels' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A three-dot icon for additional actions',
  definition_en = 'An icon (vertical dots or horizontal dots) that reveals a dropdown of additional options when clicked.',
  mechanism_en = 'Known as a "kebab menu" (vertical dots) or "meatball menu" (horizontal dots). Clicking it opens a dropdown with extra actions.',
  analogy_en = 'An ellipsis meaning "more." There are additional options, but space is limited so they are hidden behind this icon.',
  pitfall_en = 'Three dots alone don''t tell users what options are available. Adding a tooltip on hover improves discoverability.'
WHERE term = 'More options icon' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A horizontal line of items',
  definition_en = 'A horizontal arrangement of data in a table or grid. Also used as a layout container to arrange elements side by side.',
  mechanism_en = 'Achieved with display: flex; flex-direction: row; to lay children out horizontally. In tables, each row represents one data entry.',
  analogy_en = 'A shelf. Items are lined up horizontally along a single level.',
  pitfall_en = 'On small screens, rows often need to collapse into columns. Build responsive layouts that adapt to viewport width.'
WHERE term = 'Row' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A vertical line of items',
  definition_en = 'A vertical arrangement of data in a table or grid. Also used as a layout container to stack elements top-to-bottom.',
  mechanism_en = 'Achieved with display: flex; flex-direction: column; or by defining grid-template-columns for multi-column layouts.',
  analogy_en = 'A newspaper column. Content flows vertically within a defined-width strip.',
  pitfall_en = 'Too many columns make narrow screens unreadable. Reduce the column count responsively on smaller viewports.'
WHERE term = 'Column' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'The main starting screen of an app',
  definition_en = 'The primary landing page of an application — the default screen users see first and can always return to.',
  mechanism_en = 'Mapped to the root route (/). A "Home" link in the navigation bar provides a consistent way back.',
  analogy_en = 'Your front door. No matter where you go, you can always come back home.',
  pitfall_en = 'Don''t cram everything onto the home page. Focus on the most important content and clear navigation paths.'
WHERE term = 'Home' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A scannable square barcode for quick access',
  definition_en = 'Short for Quick Response code. A two-dimensional barcode that encodes URLs or data, readable by smartphone cameras for instant access.',
  mechanism_en = 'Generated with libraries like qrcode.react. Encodes text or URLs into a scannable square pattern.',
  analogy_en = 'A magic portal. Point your phone at it and you''re instantly taken to a specific destination.',
  pitfall_en = 'If printed too small, QR codes become unscannable. Always include a quiet zone (empty margin) around the code.'
WHERE term = 'QR code' AND chapter_id = 10;
