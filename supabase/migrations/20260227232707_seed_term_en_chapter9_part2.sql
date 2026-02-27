/*
  # Seed English translations for Chapter 9 terms (part 2 of 2)

  Translates the remaining 20 terms of Chapter 9 (terms 21–40).
  Topics: tooltip, dropdown, select, checkbox, radio, toggle, slider,
  progress, spinner, skeleton, accordion, tab, pagination, nav components.
*/

UPDATE terms SET
  one_liner_en = 'A small explanation shown on hover',
  definition_en = 'A small text that appears when the mouse hovers over an element. Provides supplementary info about icons or buttons.',
  mechanism_en = 'Triggered by CSS :hover or JavaScript mouse events. Positioned with position: absolute.',
  analogy_en = 'A sticky note. "What does this button do?" Hover, and a quick explanation pops up.',
  pitfall_en = 'Hover doesn''t exist on mobile. Don''t put essential information only in tooltips.'
WHERE term = 'Tooltip' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Multiple tooltips across the app',
  definition_en = 'Refers to multiple tooltips in an application, or the tooltip feature as a whole.',
  mechanism_en = 'Create a reusable Tooltip component and use it throughout the app.',
  analogy_en = 'Multiple sticky notes posted around the app—helpful explanations wherever they''re needed.',
  pitfall_en = 'Keep the design consistent. Varying styles across tooltips causes confusion.'
WHERE term = 'Tool tips' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A menu that opens to reveal choices',
  definition_en = 'A menu that opens on click or hover, displaying a list of options. Saves space while offering many choices.',
  mechanism_en = 'Click toggles open/close. Clicking outside closes it. z-index layers it above other elements.',
  analogy_en = 'Unrolling a scroll. Usually rolled up (closed), but unrolled (opened) it reveals its contents (options).',
  pitfall_en = 'Too many options make it hard to find things. Consider categories or a search feature.'
WHERE term = 'Dropdown menu' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A form element for picking from predefined options',
  definition_en = 'A form element for choosing one (or multiple) items from a fixed set of options. Displays as a dropdown.',
  mechanism_en = 'Built with <select> and <option> tags. In React, controlled with value and onChange.',
  analogy_en = 'A vending machine display. You see the available choices and pick the one you want.',
  pitfall_en = 'Native <select> is hard to style. Custom implementations or UI libraries are often used instead.'
WHERE term = 'Select' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A square toggle for on/off or multiple selections',
  definition_en = 'An input element toggled on or off by clicking. Supports multiple selections. Used for things like agreeing to terms.',
  mechanism_en = '<input type="checkbox"> — managed via the checked attribute.',
  analogy_en = 'A checklist. "Milk: checked, Eggs: unchecked"—mark off items as you go.',
  pitfall_en = 'Use checkboxes for multiple selections and radio buttons for single (exclusive) selections.'
WHERE term = 'Checkbox' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A round button for selecting exactly one option',
  definition_en = 'An input element where only one choice can be selected within a group. Used for exclusive options like gender.',
  mechanism_en = '<input type="radio" name="group"> — elements with the same name form one group.',
  analogy_en = 'Old car radio buttons. Press one and the others pop out. Only one can be selected at a time.',
  pitfall_en = 'Best for 2–5 options. For more, a <select> dropdown is more practical.'
WHERE term = 'Radio button' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A switch that flips between two states',
  definition_en = 'A switch-style UI component that toggles between two states. Commonly used for settings like dark mode.',
  mechanism_en = 'Often built by styling a checkbox. CSS transitions add a smooth animation.',
  analogy_en = 'A light switch. Flip it, and the state changes—on or off.',
  pitfall_en = 'Make the result of toggling immediately clear. Add labels or visual feedback.'
WHERE term = 'Toggle' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A draggable handle for selecting a value in a range',
  definition_en = 'A UI component where the user drags a handle to select a value within a range. Used for volume, price filters, etc.',
  mechanism_en = '<input type="range"> — min, max, and step attributes define the range and increments.',
  analogy_en = 'A thermostat dial. Slide left for cooler, right for warmer.',
  pitfall_en = 'For precise values, pair the slider with a numeric input. Sliders alone are hard to fine-tune.'
WHERE term = 'Slider' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A bar showing how far along a task is',
  definition_en = 'A bar-shaped UI component that visually indicates task completion. Used for downloads, form progress, quiz progress, etc.',
  mechanism_en = 'Width as a percentage of the parent represents progress. width: 60% means 60% done.',
  analogy_en = 'A gas gauge or thermometer. One glance tells you how much is left or done.',
  pitfall_en = 'A progress bar stuck at 0% makes users anxious. Add animation or explanatory text.'
WHERE term = 'Progress bar' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A spinning icon indicating loading',
  definition_en = 'A rotating animation icon shown during data loading or processing. A type of loading indicator.',
  mechanism_en = 'CSS animation with infinite rotate, or an SVG/GIF animation.',
  analogy_en = 'An hourglass. Spinning around to say "please wait a moment."',
  pitfall_en = 'A spinner that never stops makes users worry. Include timeout handling and error messages.'
WHERE term = 'Spinner' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A placeholder showing the page layout during loading',
  definition_en = 'A UI pattern that displays gray placeholder shapes mimicking the final layout while content loads.',
  mechanism_en = 'Gray shapes matching the content layout, often with a shimmer animation to convey "loading."',
  analogy_en = 'The framework of a building under construction. Even before completion, you can see what the building will look like.',
  pitfall_en = 'Ensure the skeleton matches the actual content layout. Mismatches cause a jarring jump when content loads.'
WHERE term = 'Skeleton loader' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A collapsible section that expands and contracts',
  definition_en = 'A UI component where clicking a heading expands or collapses the content beneath it. Common in FAQs and side menus.',
  mechanism_en = 'Click toggles height between 0 and auto. CSS transitions animate the change.',
  analogy_en = 'An accordion instrument. Pull and it expands; push and it contracts.',
  pitfall_en = 'All sections closed means no visible content. Consider opening one by default.'
WHERE term = 'Accordion' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A switchable content panel',
  definition_en = 'A UI pattern that displays multiple content panels in the same space, switching between them. Selecting one hides the others.',
  mechanism_en = 'The active tab gets a highlighted style. Only the corresponding panel is shown; the rest are hidden.',
  analogy_en = 'File folder tabs. Grab the "A" tab to see A''s documents; grab "B" for B''s.',
  pitfall_en = 'Too many tabs become hard to navigate. Keep it under 5 or consider a dropdown alternative.'
WHERE term = 'Tab' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A component containing multiple tabs',
  definition_en = 'The full component encompassing multiple tab buttons and their associated panels. A tab navigation system.',
  mechanism_en = 'A Tabs component manages a TabList (buttons) and TabPanels (content areas).',
  analogy_en = 'A complete tabbed file folder. The set of indexed tabs and the documents behind them.',
  pitfall_en = 'Consider accessibility: implement keyboard navigation (arrow keys) and proper ARIA roles.'
WHERE term = 'Tabs' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Splitting large data sets across numbered pages',
  definition_en = 'A UI pattern that divides a large amount of data into multiple pages, navigable via page numbers or controls.',
  mechanism_en = 'Calculate page count from total items and page size. Page number is often managed via query parameters.',
  analogy_en = 'Pages of a book. Everything can''t fit on one page, so you split it into pages and turn to "next."',
  pitfall_en = 'Choose between pagination and infinite scroll based on needs. Pagination is better for SEO and jumping to specific pages.'
WHERE term = 'Pagination' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'Links that help users move around a site',
  definition_en = 'A collection of links and menus that let users move through a site or app. The gateway to key pages.',
  mechanism_en = 'Wrapped in a <nav> tag with <a> links inside. The active link gets a distinct style.',
  analogy_en = 'A building directory. "1F: Reception, 2F: Conference rooms"—it shows you where everything is.',
  pitfall_en = 'Make the current location clear. Visually distinguish the active link.'
WHERE term = 'Navigation' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'The navigation bar at the top of the screen',
  definition_en = 'A navigation menu typically fixed at the top of the screen. Contains the logo, main links, search, and user menu.',
  mechanism_en = 'position: fixed or sticky pins it to the top. Flexbox arranges the items.',
  analogy_en = 'A bookmark ribbon. Always visible, letting you jump to any section quickly.',
  pitfall_en = 'There isn''t enough room on mobile. Collapse it into a hamburger menu.'
WHERE term = 'Navbar' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'A side panel for navigation or extra info',
  definition_en = 'An area placed on the left or right of the screen for navigation or supplementary information. Common in admin panels and documentation sites.',
  mechanism_en = 'Positioned with flexbox or grid. On mobile, hidden by default and toggled with a hamburger menu.',
  analogy_en = 'A book''s index. Positioned alongside the main text, letting you quickly find what you need.',
  pitfall_en = 'Don''t let the sidebar squeeze the content too much. Make it collapsible, or hide it on mobile.'
WHERE term = 'Sidebar' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'The shared area at the bottom of a page',
  definition_en = 'A common area at the very bottom of a page. Typically includes copyright notices, link collections, and contact info.',
  mechanism_en = 'Implemented with the <footer> tag. Flexbox or grid arranges its contents.',
  analogy_en = 'The colophon of a book. Author info, publisher, publication date—information placed at the very end.',
  pitfall_en = 'When content is short, the footer can float up awkwardly. Use min-height to keep it at the bottom.'
WHERE term = 'Footer' AND chapter_id = 9;

UPDATE terms SET
  one_liner_en = 'The shared area at the top of a page',
  definition_en = 'A common area at the very top of a page. Usually contains the logo, navigation, and search box.',
  mechanism_en = 'Implemented with the <header> tag. Often wraps a navbar. Can be fixed with position: sticky.',
  analogy_en = 'A book''s cover or title page. The first thing you see—titles and navigation at a glance.',
  pitfall_en = 'Don''t confuse header and navbar. The header is the region; the navbar is a component within it.'
WHERE term = 'Header' AND chapter_id = 9;
