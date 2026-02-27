/*
  # Seed English translations for Chapter 15 terms (Part 1: terms 1-15)
  
  Chapter 15 covers Backend, APIs, and REST concepts.
  Updates the first 15 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'The server-side of an application',
  definition_en = 'The part of a system that runs on the server, hidden from the user. Handles database operations, authentication, and business logic.',
  mechanism_en = 'Receives requests from clients, processes them, and returns responses. Built with Node.js, Python, Java, and similar server-side technologies.',
  analogy_en = 'A restaurant kitchen. Invisible to diners, but it''s where orders are received and meals are prepared.',
  pitfall_en = 'Backend errors are harder for users to see. Proper logging and error handling are essential for diagnosing issues.'
WHERE term = 'Backend' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'An alternate spelling of Backend',
  definition_en = 'Identical in meaning to "Backend." Sometimes written as "Back end" or "Back-end" depending on style conventions.',
  mechanism_en = 'The meaning is the same. Teams typically standardize on one spelling for consistency.',
  analogy_en = 'Like "grey" vs. "gray" — same thing, different spelling conventions.',
  pitfall_en = 'Pick one spelling and stick with it across documentation and code. Inconsistency makes searching harder.'
WHERE term = 'Back end' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A computer or program that responds to requests',
  definition_en = 'A computer or software process that listens for incoming requests, processes them, and sends back responses.',
  mechanism_en = 'Runs continuously, waiting for requests. Types include web servers, database servers, and mail servers.',
  analogy_en = 'A waiter. Takes orders (requests) from customers (clients) and delivers the meals (data).',
  pitfall_en = 'Server downtime is critical. Redundancy and monitoring systems minimize outages.'
WHERE term = 'Server' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'Processing that happens on the server',
  definition_en = 'Operations executed on the server rather than in the user''s browser. Security-sensitive work like authentication and database access belongs here.',
  mechanism_en = 'Receives requests, performs database queries, runs authentication checks, and executes business logic before returning a response.',
  analogy_en = 'A bank vault room. Sensitive operations happen in a secure back room, not at the public counter.',
  pitfall_en = 'Always handle secrets (API keys, etc.) server-side. Never expose them to the client.'
WHERE term = 'Server side' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'Processing that happens in the browser',
  definition_en = 'Operations executed on the user''s browser or device. Handles UI interactions, form validation, and other immediate-response tasks.',
  mechanism_en = 'JavaScript runs directly in the browser, providing instant responses without needing a server round-trip.',
  analogy_en = 'In-store customer service. Handled right in front of the customer for immediate feedback.',
  pitfall_en = 'Client-side validation can be bypassed. Always duplicate validation on the server side for security.'
WHERE term = 'Client side' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The part users see and interact with',
  definition_en = 'The user-facing layer of an application, built with HTML, CSS, and JavaScript. Responsible for the visual interface and user experience.',
  mechanism_en = 'Rendered in the browser. Captures user interactions and communicates with the backend via API calls.',
  analogy_en = 'A storefront. The part of the shop where customers browse, interact, and make purchases.',
  pitfall_en = 'Frontend alone is incomplete. It needs to be designed with backend integration in mind.'
WHERE term = 'Frontend' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'An alternate spelling of Frontend',
  definition_en = 'Identical in meaning to "Frontend." Sometimes written as "Front end" or "Front-end" depending on style preferences.',
  mechanism_en = 'The meaning is the same. The difference is purely stylistic — with or without a hyphen or space.',
  analogy_en = 'Like "website" vs. "web site" — the same concept, just different formatting.',
  pitfall_en = 'Standardize the spelling within your team. Consistency in code and documentation matters.'
WHERE term = 'Front end' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'Both frontend and backend together',
  definition_en = 'Refers to the entire web application stack — from the user interface to the server and database. A "full-stack developer" works across all layers.',
  mechanism_en = 'Spans UI design, frontend implementation, API development, database design, and infrastructure management.',
  analogy_en = 'A restaurant owner-chef. Handles everything from greeting guests to cooking to managing the business.',
  pitfall_en = 'Knowing everything broadly doesn''t mean knowing everything deeply. Build strong expertise in some areas while maintaining breadth.'
WHERE term = 'Full stack' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A specific URL where an API can be accessed',
  definition_en = 'A URL exposed by an API that provides access to a specific resource or function. Examples: /users, /products/:id.',
  mechanism_en = 'An HTTP method paired with a URL path identifies the operation. GET /users means "retrieve the list of users."',
  analogy_en = 'Doors into a building. There''s a front entrance, an employee entrance, and a loading dock — each serves a different purpose.',
  pitfall_en = 'Design endpoints RESTfully: use nouns for resources (URLs) and verbs for actions (HTTP methods).'
WHERE term = 'Endpoint' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A mapping from a URL to a handler function',
  definition_en = 'A configuration that links a specific URL pattern to the function that should handle requests to that URL.',
  mechanism_en = 'Defined like app.get(''/users'', getUsers) — connecting a URL pattern to a handler function.',
  analogy_en = 'Directional signs. "This way to Point A," "That way to Point B" — guiding requests to the right handler.',
  pitfall_en = 'Route order matters. Define /users/new before /users/:id, or "new" will be interpreted as an ID parameter.'
WHERE term = 'Route' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The collection of all defined routes',
  definition_en = 'All the routes defined in an application, taken together. May also refer to the overall routing configuration.',
  mechanism_en = 'Often organized into separate files like routes/users.js and routes/products.js for maintainability.',
  analogy_en = 'A road atlas. A complete map of every path (route) available in the application.',
  pitfall_en = 'When routes grow numerous, reorganize them. Split by resource or domain into separate files.'
WHERE term = 'Routes' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'Controlling who can access which routes',
  definition_en = 'Restricting access to certain routes based on authentication and authorization. For example, "logged-in users only" or "admins only."',
  mechanism_en = 'Implemented via middleware that checks tokens, verifies permissions, and rejects unauthorized access.',
  analogy_en = 'Castle gate guards. They check your credentials (token) and only allow authorized people through.',
  pitfall_en = 'Security should be layered. Route-level protection alone isn''t enough — also enforce data-level permission checks.'
WHERE term = 'Route security' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A module that directs requests to the right handler',
  definition_en = 'A module responsible for matching incoming request URLs to the appropriate handler functions. Examples: Express Router, Next.js App Router.',
  mechanism_en = 'Pattern-matches URLs, extracts parameters, and dispatches to the correct handler function.',
  analogy_en = 'A traffic officer. Looks at each vehicle (request) and directs it to the correct road (handler).',
  pitfall_en = 'Don''t confuse this with a network router (hardware). In software, a router directs URL traffic to code.'
WHERE term = 'Router' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The layer that receives requests and delegates work',
  definition_en = 'In the MVC pattern, the layer that receives incoming requests and coordinates between the Model (data) and the View (presentation).',
  mechanism_en = 'Called by routes, it orchestrates business logic (via Services) and data operations (via Models).',
  analogy_en = 'An orchestra conductor. Directs each section (Model, View) to play their part in harmony.',
  pitfall_en = 'Don''t overload controllers with logic. Move business rules into a dedicated Service layer.'
WHERE term = 'Controller' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The layer that defines data structure and access',
  definition_en = 'In MVC architecture, the layer that defines data structure, validation, and database operations.',
  mechanism_en = 'Maps to database tables. Often defined using ORMs like Prisma, Sequelize, or Mongoose.',
  analogy_en = 'A blueprint and warehouse clerk. Defines the shape of data (blueprint) and manages its storage and retrieval (clerk).',
  pitfall_en = 'Don''t put too much business logic in Models. Keep them focused on data access.'
WHERE term = 'Model' AND chapter_id = 15;
