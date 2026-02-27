/*
  # Seed English translations for Chapter 12 terms (Part 2: terms 14-25)
  
  Continues Chapter 12 Development Tools and Debugging.
  Updates the remaining 12 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'A panel that shows logs and errors',
  definition_en = 'A panel in browser dev tools that displays console.log output, JavaScript errors, and warnings. You can also type and execute JavaScript directly in it.',
  mechanism_en = 'Shows output from console.log(), console.error(), and similar methods. Also serves as an interactive JavaScript REPL.',
  analogy_en = 'A window into your program''s inner monologue. It shows messages like "got here" and "this value is X" that your code records.',
  pitfall_en = 'Remove console.log statements before deploying to production. Use a logging system or log levels for production code.'
WHERE term = 'Console panel' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A panel that shows network requests',
  definition_en = 'A dev tools panel that lists all HTTP requests and responses made by the page. Essential for debugging API calls and loading issues.',
  mechanism_en = 'Displays each request''s URL, status code, timing, size, and full response body.',
  analogy_en = 'A postal delivery log. It records every letter (request) sent and every reply (response) received.',
  pitfall_en = 'Sensitive data like auth tokens may be visible in network logs. Be cautious when sharing screenshots of this panel.'
WHERE term = 'Network panel' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A record of all network communications',
  definition_en = 'The list of network requests shown in the Network panel. Each entry contains full details including headers, payload, and response.',
  mechanism_en = 'Requests are recorded chronologically. Filters let you narrow down to specific types like XHR, Fetch, images, etc.',
  analogy_en = 'A call history log. It records who (which URL) you communicated with, when, and what was said.',
  pitfall_en = 'Logs are cleared on page navigation. Check "Preserve log" to keep records across page loads.'
WHERE term = 'Network log' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A tool for finding and fixing bugs',
  definition_en = 'A tool that pauses program execution so you can inspect variable values and step through code line by line. Uses breakpoints to control where execution stops.',
  mechanism_en = 'Set a breakpoint on a specific line. When execution reaches it, the program pauses. You can then step through code and watch variable values change.',
  analogy_en = 'Pausing and frame-advancing a video. Stop the program and move through it slowly to see exactly what happens.',
  pitfall_en = 'console.log debugging works for simple cases, but the debugger is far more efficient for complex problems.'
WHERE term = 'Debugger' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'The history of function calls currently in progress',
  definition_en = 'A record of which function called which, showing the chain of execution leading to the current point. Used during debugging to trace the flow of logic.',
  mechanism_en = 'When function A calls B, and B calls C, the stack reads A -> B -> C. When C finishes, execution returns to B.',
  analogy_en = 'Layers in a hamburger. Bun, patty, cheese stack up from bottom to top — and you consume (process) from the top down.',
  pitfall_en = 'A stack overflow error occurs when recursion goes too deep and exceeds the maximum call stack size.'
WHERE term = 'Call stack' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'The chain of calls shown when an error occurs',
  definition_en = 'The sequence of function calls displayed when an error is thrown, showing exactly which function on which line triggered the problem.',
  mechanism_en = 'Appears alongside the error message. Lists calling functions in reverse order — from the error site back to the original caller — with file names and line numbers.',
  analogy_en = 'A route map to an accident scene. It traces the path that led to the crash, step by step.',
  pitfall_en = 'Build the habit of reading stack traces carefully. They contain the most important clues for resolving errors.'
WHERE term = 'Stack trace' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'Reloading a page to get the latest version',
  definition_en = 'Reloading a web page to fetch and display the latest content. Triggered with F5 or the browser''s refresh button.',
  mechanism_en = 'Requests the latest HTML, CSS, and JS from the server. If cached versions exist, the browser may use those instead.',
  analogy_en = 'Opening a window to let in fresh air. You bring in new data to refresh the view.',
  pitfall_en = 'Cached files may prevent you from seeing updates. If changes don''t appear, try a hard refresh instead.'
WHERE term = 'Refresh' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A refresh that ignores the browser cache',
  definition_en = 'A forced page reload that bypasses the browser cache, fetching every resource fresh from the server. Triggered with Ctrl+Shift+R (or Cmd+Shift+R on Mac).',
  mechanism_en = 'Unlike a normal refresh which may use cached files, a hard refresh downloads all assets from scratch.',
  analogy_en = 'A deep clean. Instead of regular tidying (normal refresh), you scrub everything from top to bottom (clear cache and reload).',
  pitfall_en = 'This is the go-to fix when changes aren''t showing up. Try a hard refresh before investigating further.'
WHERE term = 'Hard refresh' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'Saving the screen as an image',
  definition_en = 'Capturing what is currently displayed on screen as an image file. Used for bug reports, design reviews, and documentation. Dev tools can capture full-page screenshots.',
  mechanism_en = 'Use OS features (PrintScreen, etc.), browser tools, or extensions. Chrome DevTools can capture screenshots of the entire scrollable page.',
  analogy_en = 'Taking a photo of your screen. It preserves exactly what you see at that moment.',
  pitfall_en = 'Check for sensitive information before sharing screenshots. Tokens, passwords, or personal data may be visible.'
WHERE term = 'Screenshot' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'A problem that prevents code from working correctly',
  definition_en = 'A condition where a program does not behave as expected. Errors fall into categories like syntax errors, runtime errors, and logic errors.',
  mechanism_en = 'When an error occurs, the program may halt or behave unexpectedly. try/catch blocks let you handle errors gracefully.',
  analogy_en = 'A recipe that went wrong. Somewhere in the steps, something was done incorrectly — and the result isn''t what was expected.',
  pitfall_en = 'Read error messages carefully. They almost always contain the clues needed to find and fix the problem.'
WHERE term = 'Error' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'When a program stops unexpectedly',
  definition_en = 'An unrecoverable failure that forces a program or application to shut down. The user can no longer interact with it until it''s restarted.',
  mechanism_en = 'Caused by memory exhaustion, infinite loops, unhandled exceptions, or other fatal conditions. The app becomes unresponsive or disappears.',
  analogy_en = 'A car engine stalling. Something was running, then suddenly it stops — and you need to restart.',
  pitfall_en = 'When a crash happens, check logs and error reports to identify the root cause before attempting a fix.'
WHERE term = 'Crash' AND chapter_id = 12;

UPDATE terms SET
  one_liner_en = 'An error caused by a failed connection',
  definition_en = 'An error that occurs when communication with a server fails — due to no internet connection, a timeout, DNS failure, or the server refusing the request.',
  mechanism_en = 'Triggers when fetch() or API requests fail. Diagnosing requires checking both the network conditions and server status.',
  analogy_en = 'A phone call that won''t connect. Either the other party (server) isn''t answering or the signal (network) isn''t reaching.',
  pitfall_en = 'Network errors are often temporary. Implementing automatic retry logic handles most transient failures.'
WHERE term = 'Network error' AND chapter_id = 12;
