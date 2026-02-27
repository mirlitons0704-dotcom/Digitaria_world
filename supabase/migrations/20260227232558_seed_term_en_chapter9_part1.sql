/*
  # Seed English translations for Chapter 9 terms (part 1 of 2)

  Translates the first 20 terms of Chapter 9.
  Topics: page, component, layout, card, button, forms, modals, dialogs,
  popups, overlays, toast, notification, alert, tooltip.
*/

UPDATE terms SET
  one_liner_en = 'A single screen in an app',
  definition_en = 'One screen unit within a web application. Different URLs typically display different pages.',
  mechanism_en = 'In Next.js, files in the pages folder (or app folder with App Router) correspond to individual pages.',
  analogy_en = 'A page in a book. Turn the page (change the URL) and a different screen appears.',
  pitfall_en = 'In a Single Page Application (SPA), one HTML file handles all page transitions. This differs from the traditional notion of a "page."'
WHERE term = 'Page' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A reusable building block of a UI',
  definition_en = 'A reusable piece of UI. Buttons, cards, headers—each has its own independent functionality and appearance.',
  mechanism_en = 'In React, defined as a function or class. Components are composed together to build screens.',
  analogy_en = 'LEGO bricks. Snap small pieces together to create something larger.',
  pitfall_en = 'Follow the single responsibility principle. Don''t overload one component with too many roles.'
WHERE term = 'Component' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'The arrangement of elements on a page',
  definition_en = 'The spatial arrangement of page elements—header, sidebar, content area, etc. Multiple pages often share a common layout.',
  mechanism_en = 'In Next.js, defined in layout.tsx. Contains shared elements like headers and footers, with children rendering each page.',
  analogy_en = 'A floor plan. It defines where the entrance, living room, and kitchen go.',
  pitfall_en = 'Layouts can be nested. Design them hierarchically: whole-page layout, section layout, etc.'
WHERE term = 'Layout' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Multiple layout patterns for different purposes',
  definition_en = 'Different layouts used for different sections of an app—one for the admin panel, another for regular users, etc.',
  mechanism_en = 'Different layouts are applied to different routes, or switched based on conditions.',
  analogy_en = 'Outfits for a paper doll. The same doll (content) wears different clothes (layouts).',
  pitfall_en = 'Too many layouts become hard to manage. Extract shared parts into a base layout.'
WHERE term = 'Layouts' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A box that groups related information',
  definition_en = 'A UI component that presents related information—image, title, description—as a grouped unit. Typically styled with shadows and rounded corners.',
  mechanism_en = 'Styled with border-radius and box-shadow for a "floating" look. Flexbox or grid arranges the contents inside.',
  analogy_en = 'A trading card. One card bundles an image, a name, and stats together.',
  pitfall_en = 'Don''t overcrowd a card. Too much information makes it hard to scan.'
WHERE term = 'Card' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A clickable element that triggers an action',
  definition_en = 'A UI element users click or tap to perform an action—submit, delete, navigate, and more.',
  mechanism_en = 'Implemented with the <button> tag or an ARIA role. Event handlers like onClick execute the logic.',
  analogy_en = 'An elevator button. Press it and something happens. The label tells you which floor (action) you''re going to.',
  pitfall_en = 'Use links for navigation and buttons for actions. Don''t mix them up.'
WHERE term = 'Button' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A field for typing text or numbers',
  definition_en = 'A form element where users enter text or numbers. Used for names, emails, passwords, and more.',
  mechanism_en = 'Implemented with the <input> tag. The type attribute specifies text, email, password, number, etc.',
  analogy_en = 'A blank on an application form. A designated spot where you write specific information.',
  pitfall_en = 'Use the right type attribute. email shows an email keyboard on mobile; number shows a numeric keypad.'
WHERE term = 'Input field' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A container that groups inputs for submission',
  definition_en = 'A container that bundles multiple input fields together for data submission. Used for login, registration, search, etc.',
  mechanism_en = 'Wrapped in a <form> tag. onSubmit handles the event, and preventDefault stops the page from reloading.',
  analogy_en = 'An entire application form. Multiple fields (inputs) with a "submit" button at the end.',
  pitfall_en = 'A <button> inside a form defaults to type="submit". Set type="button" explicitly to prevent accidental submission.'
WHERE term = 'Form' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Sending form data to the server',
  definition_en = 'The act of sending form input data to a server, or the submit button itself.',
  mechanism_en = '<button type="submit"> or pressing Enter inside a form fires a submit event.',
  analogy_en = 'Handing your application form to the clerk at a counter. Once you''re done filling it out, you press "submit."',
  pitfall_en = 'Always validate before submitting. Prevent invalid data from reaching the server.'
WHERE term = 'Submit' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Descriptive text for an input field',
  definition_en = 'Text indicating the purpose of an input field—"Name," "Email Address," etc.',
  mechanism_en = '<label for="id"> associates the label with a field. Clicking the label focuses the corresponding input.',
  analogy_en = 'The heading above a form field: "Name: ___" — the "Name:" part is the label.',
  pitfall_en = 'For accessibility, always associate a label with its input.'
WHERE term = 'Label' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Hint text shown when an input is empty',
  definition_en = 'Light-colored text displayed inside an empty input field. Shows an example or format hint, and disappears when you start typing.',
  mechanism_en = 'Set with the placeholder attribute. Vanishes once input begins.',
  analogy_en = 'A sample entry: "e.g., John Smith"—showing you what to type.',
  pitfall_en = 'Don''t use placeholder as a substitute for a label. It vanishes after input, so a label is still needed.'
WHERE term = 'Placeholder' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Checking whether input values are correct',
  definition_en = 'Verifying that form input meets requirements—required fields, correct format, proper length, etc.',
  mechanism_en = 'Performed on both the client (JavaScript) and the server. HTML attributes like required and pattern also help.',
  analogy_en = 'A document review. A clerk checks for missing or incorrect information.',
  pitfall_en = 'Client-side validation alone is not enough—it can be bypassed. Always validate on the server too.'
WHERE term = 'Validation' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A message telling the user something went wrong',
  definition_en = 'Text that informs the user about a validation error or system error. Should explain what is wrong and how to fix it.',
  mechanism_en = 'Manage error state and display with conditional rendering. Often styled in red for visibility.',
  analogy_en = 'A teacher''s red pen. "This part is wrong"—pointing out the specific issue.',
  pitfall_en = 'Just saying "Error" is unhelpful. Be specific about what went wrong and how to fix it.'
WHERE term = 'Error message' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A window that overlays the main content',
  definition_en = 'A small window layered on top of the main content. Used for confirmations, detail views, etc. Blocks interaction with the content behind it.',
  mechanism_en = 'z-index brings it to the front; an overlay darkens the background. Typically closable via ESC or background click.',
  analogy_en = 'A pop-up shop. It appears in front of the main store (screen), and you can''t enter the main store until it''s dealt with.',
  pitfall_en = 'Don''t overuse modals. They interrupt the user''s workflow, so reserve them for when they''re truly needed.'
WHERE term = 'Modal' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A small window requesting user confirmation or input',
  definition_en = 'A popup window that asks the user for confirmation, acknowledgement, or input. A type of modal.',
  mechanism_en = 'Implemented with the HTML5 <dialog> element, or JavaScript''s alert/confirm/prompt.',
  analogy_en = 'A clerk asking for confirmation: "Are you sure?" before proceeding.',
  pitfall_en = 'Native alert/confirm cannot be styled. Most projects use a UI library for custom dialogs.'
WHERE term = 'Dialog box' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A temporary element that appears on screen',
  definition_en = 'A general term for elements that appear temporarily on screen in response to clicks, hovers, etc. Includes tooltips, dropdowns, and modals.',
  mechanism_en = 'Toggled via display: none/block or positioned with position: absolute. z-index brings it to the front.',
  analogy_en = 'A pop-up book. Open the page and something pops out.',
  pitfall_en = 'Too many popups annoy users. Use them sparingly and appropriately.'
WHERE term = 'Popup' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A semi-transparent layer covering the entire screen',
  definition_en = 'A semi-transparent layer placed over the whole screen behind a modal. Darkens the background to focus attention on the foreground element.',
  mechanism_en = 'position: fixed covers the viewport; background-color with rgba creates the translucent dark layer.',
  analogy_en = 'A spotlight on a stage. The surroundings go dark, making the star (modal) stand out.',
  pitfall_en = 'Clicking the overlay to close the modal is a common UX expectation. Implement it.'
WHERE term = 'Overlay' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A brief notification that auto-dismisses',
  definition_en = 'A short notification message that temporarily appears at the edge of the screen and automatically fades away after a few seconds.',
  mechanism_en = 'position: fixed at a screen edge. setTimeout triggers a fade-out after a few seconds.',
  analogy_en = 'Toast popping out of a toaster. It appears briefly and disappears if you don''t grab it.',
  pitfall_en = 'Don''t use toasts for critical information—they can be missed. Use a different approach for errors.'
WHERE term = 'Toast' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A mechanism for alerting users to new information',
  definition_en = 'A system for informing users about new information or updates. Includes in-app notifications, push notifications, and email alerts.',
  mechanism_en = 'Web Push API for browser notifications. In-app options include badges, toasts, and notification lists.',
  analogy_en = 'A bell ringing. "You have a new update!"—something that gets the user''s attention.',
  pitfall_en = 'Too many notifications get ignored. Only notify for genuinely important information.'
WHERE term = 'Notification' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A prominent display of important information',
  definition_en = 'A UI component that displays warnings, errors, success messages, or informational notices in a visually prominent style.',
  mechanism_en = 'Color-coded by meaning: red for error, yellow for warning, green for success, blue for info. May include a close button.',
  analogy_en = 'Road signs and traffic lights. Red means "danger!" and green means "safe"—color conveys meaning at a glance.',
  pitfall_en = 'Don''t rely on color alone. Include icons and text to support users with color vision differences.'
WHERE term = 'Alert' AND chapter_id = 9;
