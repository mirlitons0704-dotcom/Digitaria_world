/*
  # Seed English translations for Chapter 10 terms (Part 1: terms 1-20)
  
  Chapter 10 covers UI/UX Design concepts.
  Updates the first 20 terms with English translations for:
  one_liner_en, definition_en, mechanism_en, analogy_en, pitfall_en
*/

UPDATE terms SET
  one_liner_en = 'Both how it looks and how it feels',
  definition_en = 'UI (User Interface) refers to the visual elements and controls on screen. UX (User Experience) refers to the overall experience a user has with a product. Good design addresses both.',
  mechanism_en = 'UI focuses on visual design — colors, layouts, buttons. UX encompasses usability, clarity, satisfaction, and the entire journey a user takes through a product.',
  analogy_en = 'A restaurant. UI is the interior decor and tableware. UX is the full dining experience — service, taste, and ambiance combined.',
  pitfall_en = 'A beautiful interface that is hard to use is not good UX. Balancing appearance and usability is essential.'
WHERE term = 'UI/UX' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'The point of contact between user and system',
  definition_en = 'The visual elements through which users interact with a system — buttons, menus, forms, and everything visible on screen.',
  mechanism_en = 'Built with HTML, CSS, and JavaScript. Often designed first in tools like Figma before being implemented in code.',
  analogy_en = 'A car''s cockpit. The steering wheel, pedals, and dashboard are the interface through which the driver operates the vehicle.',
  pitfall_en = 'UI is only one part of UX. A polished interface means nothing if the overall experience is frustrating.'
WHERE term = 'User interface' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'The complete experience of using a product',
  definition_en = 'Everything a user feels while interacting with a product or service — ease of use, efficiency, satisfaction, and emotional response.',
  mechanism_en = 'Designed and improved through user research, persona creation, customer journey mapping, and iterative testing.',
  analogy_en = 'A vacation memory. It''s not just the hotel or the flight — it''s the entire trip experience combined.',
  pitfall_en = 'UX is subjective and hard to measure. Continuous improvement through user testing and feedback is necessary.'
WHERE term = 'User experience' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A blueprint showing a screen''s skeleton',
  definition_en = 'A simple, low-fidelity sketch of a screen layout using lines and boxes to show where elements go. It excludes colors and detailed styling.',
  mechanism_en = 'Created in Figma, Sketch, or even on paper. Used to confirm element placement and information structure before detailed design begins.',
  analogy_en = 'A house floor plan. It shows room arrangements without wallpaper colors or furniture details.',
  pitfall_en = 'Finalize layout and flow at the wireframe stage. Major changes later cause significant rework.'
WHERE term = 'Wireframe' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A design that looks close to the finished product',
  definition_en = 'A high-fidelity visual design that includes colors, fonts, and images — much closer to the actual product than a wireframe.',
  mechanism_en = 'Created in Figma, Adobe XD, or similar tools. Used to review and approve the visual design before development starts.',
  analogy_en = 'A model home in a housing showroom. You can see what the finished product will look like before moving in.',
  pitfall_en = 'Mockups are static images. To test actual interactions and flow, you need a prototype.'
WHERE term = 'Mockup' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A collection of design rules and reusable parts',
  definition_en = 'A unified set of standards that includes colors, fonts, components, and usage guidelines — ensuring design consistency across a product.',
  mechanism_en = 'Composed of design tokens, a component library, and documentation. Shared across the entire team for consistent output.',
  analogy_en = 'A LEGO instruction manual with a parts kit. It provides both the building blocks and the rules for assembly.',
  pitfall_en = 'A design system isn''t "set it and forget it." It requires ongoing maintenance and updates.'
WHERE term = 'Design system' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A collection of reusable UI parts',
  definition_en = 'A library of pre-built, reusable UI components like buttons, cards, and forms. Popular examples include MUI and Chakra UI.',
  mechanism_en = 'Installed via npm and used through imports. Components can be customized to fit your design needs.',
  analogy_en = 'A furniture catalog. You pick ready-made pieces and arrange them, rather than building everything from scratch.',
  pitfall_en = 'Over-relying on a library can make unique designs harder to achieve. Check customization options before committing.'
WHERE term = 'Component library' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'Design values stored as variables',
  definition_en = 'Named variables that store design values like colors, font sizes, and spacing. They enable consistency and make bulk changes easy.',
  mechanism_en = 'Defined as CSS variables or in config files. For example: --color-primary: #3B82F6; gives a named reference to a specific color.',
  analogy_en = 'A paint swatch book. You name each color — like "Primary Blue" — and use the same one everywhere.',
  pitfall_en = 'Use meaningful token names. "primary-color" communicates better than "blue-500" because it describes purpose, not appearance.'
WHERE term = 'Design tokens' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A set of visual styles for the entire app',
  definition_en = 'A bundled collection of colors, fonts, and spacing that defines an app''s look. Themes can be switched — for example, between light and dark mode.',
  mechanism_en = 'Managed through CSS variables or a ThemeProvider component. The active theme changes based on user preference or system settings.',
  analogy_en = 'Dress-up outfits for the same doll. The app stays the same underneath, but its appearance changes with each theme.',
  pitfall_en = 'When switching themes, test that every element updates correctly — missed elements look broken.'
WHERE term = 'Theme' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A design mode with a bright background',
  definition_en = 'A visual style using white or light colors as the base. Best suited for daytime or well-lit environments.',
  mechanism_en = 'Uses light backgrounds with dark text. The prefers-color-scheme media query can detect the user''s OS-level preference.',
  analogy_en = 'A room with the curtains open on a sunny day — bright and easy to see.',
  pitfall_en = 'Light mode is great in sunlight, but can feel harsh in dark settings. Offering a dark mode toggle is ideal.'
WHERE term = 'Light mode' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A design mode with a dark background',
  definition_en = 'A visual style using black or dark colors as the base. Reduces eye strain in low-light conditions and can save battery on OLED screens.',
  mechanism_en = 'Uses dark backgrounds with light text. On OLED displays, pure black pixels consume zero power.',
  analogy_en = 'Working in a dimly lit room — softer on the eyes, especially at night.',
  pitfall_en = 'Simply inverting black and white is not enough. Contrast ratios and color saturation need careful adjustment.'
WHERE term = 'Dark mode' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'The combination of colors used in an app',
  definition_en = 'The set of colors chosen for an application — including primary, accent, and background colors — that work together harmoniously.',
  mechanism_en = 'Defined in design tools or CSS variables. The 60-30-10 rule is a common guideline: 60% dominant, 30% secondary, 10% accent.',
  analogy_en = 'Interior color coordination. Walls, furniture, and accents need to complement each other.',
  pitfall_en = 'Too many colors destroy visual harmony. Limit your palette to around 3-5 colors.'
WHERE term = 'Color scheme' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A 6-digit color code starting with #',
  definition_en = 'A way to represent colors using hexadecimal values. Written as #RRGGBB, where each pair (00-FF) specifies the red, green, or blue intensity. #FFFFFF is white, #000000 is black.',
  mechanism_en = 'Used in CSS like color: #3B82F6;. A shorthand 3-digit form (#RGB) is also valid.',
  analogy_en = 'A paint mixing recipe. "Mix 3B parts red, 82 parts green, and F6 parts blue."',
  pitfall_en = 'Forgetting the # prefix will cause it to fail silently. Letter casing does not matter.'
WHERE term = 'Hex color' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'Red, Green, Blue — the three primary colors of light',
  definition_en = 'A color model that combines Red, Green, and Blue light to produce colors. Each channel ranges from 0 to 255.',
  mechanism_en = 'Used in CSS as color: rgb(59, 130, 246);. The rgba() variant adds an alpha channel for transparency.',
  analogy_en = 'Mixing three spotlights. Overlapping red, green, and blue light beams to create any color.',
  pitfall_en = 'RGB is additive mixing — combining colors makes them brighter. This is different from CMYK (subtractive mixing) used in printing.'
WHERE term = 'RGB' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'How see-through an element is',
  definition_en = 'A property that controls an element''s transparency. Values range from 0 (fully transparent) to 1 (fully opaque).',
  mechanism_en = 'Set in CSS with opacity: 0.5; for 50% transparency. The rgba() function can also set transparency on individual colors.',
  analogy_en = 'Frosted glass. You adjust the level of transparency to let varying amounts show through.',
  pitfall_en = 'opacity affects the entire element including its children. To make only the background transparent, use rgba() instead.'
WHERE term = 'Opacity' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A typeface for displaying text',
  definition_en = 'The visual style applied to text characters. Fonts come in many varieties — serif, sans-serif, handwritten, and more.',
  mechanism_en = 'Set in CSS with font-family. Multiple fonts can be listed as fallbacks in case the preferred one isn''t available.',
  analogy_en = 'Handwriting versus print. The same words carry a different feel depending on the typeface used.',
  pitfall_en = 'If a font isn''t installed on the user''s device, it won''t display. Use web fonts or specify reliable fallbacks.'
WHERE term = 'Font' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'The art of styling text',
  definition_en = 'The discipline covering font choice, sizing, line spacing, letter spacing, and weight — everything related to how text looks and reads.',
  mechanism_en = 'Controlled through CSS properties like font-size, line-height, letter-spacing, and font-weight.',
  analogy_en = 'A fashion outfit for text. The font is the clothing, the size is the fit, and the spacing is the silhouette.',
  pitfall_en = 'Readability always comes first. Typography that looks stylish but is hard to read defeats its own purpose.'
WHERE term = 'Typography' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'A prioritized list of fonts to use',
  definition_en = 'A CSS property that specifies which fonts to use, in order of preference. If the first font is unavailable, the browser tries the next one.',
  mechanism_en = 'Written as font-family: ''Noto Sans JP'', sans-serif;. Always end with a generic family name as the final fallback.',
  analogy_en = 'Restaurant reservations with backup options. "If the first pick is full, try the next one on the list."',
  pitfall_en = 'Font names containing spaces must be wrapped in quotes. Always include a generic family (serif, sans-serif, monospace) at the end.'
WHERE term = 'Font family' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'How thick or thin text characters are',
  definition_en = 'A property controlling the boldness of text. Values range from 100 (ultra-thin) to 900 (ultra-bold), with normal being 400 and bold being 700.',
  mechanism_en = 'Set with font-weight: 700; or font-weight: bold;. The font file must include the requested weight for it to render correctly.',
  analogy_en = 'Pen thickness. Writing with a fine pen versus a thick marker produces very different visual weight.',
  pitfall_en = 'If a font doesn''t support the specified weight, the browser substitutes the closest available weight.'
WHERE term = 'Font weight' AND chapter_id = 10;

UPDATE terms SET
  one_liner_en = 'How large text characters appear',
  definition_en = 'A property that sets the size of text. Specified in units like px, rem, or em.',
  mechanism_en = 'Set with font-size: 16px; or font-size: 1rem;. rem is relative to the root element''s font size, making it responsive-friendly.',
  analogy_en = 'The height of characters. Headlines are tall, body text is standard, and fine print is small.',
  pitfall_en = 'px is a fixed value; rem and em are relative. For accessibility, rem is recommended so users can adjust their base font size.'
WHERE term = 'Font size' AND chapter_id = 10;
