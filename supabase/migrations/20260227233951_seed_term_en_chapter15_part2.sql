/*
  # Seed English translations for Chapter 15 terms (Part 2: terms 16-30)
  
  Continues Chapter 15 Backend, APIs, and REST concepts.
  Updates the remaining 15 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'Code that runs between a request and its handler',
  definition_en = 'Processing that executes before a request reaches its handler (or before a response is sent). Used for authentication, logging, error handling, and more.',
  mechanism_en = 'Middleware functions are chained together. Each calls next() to pass control to the next one, or can halt the chain.',
  analogy_en = 'Airport security checkpoints. Before boarding (reaching the handler), you pass through multiple inspection stages.',
  pitfall_en = 'Middleware order matters. Authentication middleware must run before the route handler, not after.'
WHERE term = 'Middleware' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The function that processes a specific request',
  definition_en = 'A function bound to a route that performs the actual work — receiving a request and producing a response.',
  mechanism_en = 'Typically written as async function handler(req, res) { ... }. Processes the request and returns data.',
  analogy_en = 'A service desk agent. Listens to the visitor''s request and takes care of it.',
  pitfall_en = 'Keep handlers simple. Delegate complex logic to a Service layer.'
WHERE term = 'Handler' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A layer that contains business logic',
  definition_en = 'A layer that encapsulates the application''s core business rules and processing. Called by Controllers to perform the actual work.',
  mechanism_en = 'Handles data transformation, external API calls, and complex conditional logic. Designed for high reusability.',
  analogy_en = 'Specialized departments. Accounting, HR, and operations each handle their own domain of expertise.',
  pitfall_en = 'Keep Services free from HTTP and database concerns. Pure business logic is easier to test and reuse.'
WHERE term = 'Service' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The rules and logic specific to your application',
  definition_en = 'The processing rules unique to your application — pricing calculations, permission checks, workflows, and domain-specific decisions.',
  mechanism_en = 'Implemented in the Service layer. Kept independent from UI and database so it''s testable and maintainable.',
  analogy_en = 'Company policies. "Approve if this condition is met," "Apply a discount at this threshold" — rules specific to the business.',
  pitfall_en = 'Don''t scatter business logic across the UI and database layers. Centralize it in one place for easier management.'
WHERE term = 'Business logic' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A design style for web APIs',
  definition_en = 'Stands for Representational State Transfer. An API design approach that uses HTTP methods and URLs to operate on resources.',
  mechanism_en = 'GET (read), POST (create), PUT (update), DELETE (remove) act on resources. The server is stateless between requests.',
  analogy_en = 'Library usage rules. There are established procedures for borrowing, returning, and reserving books.',
  pitfall_en = 'REST is a set of principles, not a strict specification. Teams should agree on how strictly they follow it.'
WHERE term = 'REST' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'Designed according to REST principles',
  definition_en = 'Describes an API that follows REST principles — stateless communication, resource-oriented URLs, and standard HTTP methods.',
  mechanism_en = 'URLs represent resources as nouns (/users, /users/123). Actions are expressed through HTTP methods, not URL verbs.',
  analogy_en = 'Following proper etiquette. Behaving according to the established rules (REST) in a predictable, standardized way.',
  pitfall_en = 'Being perfectly RESTful isn''t always necessary. Balance purity with practical needs.'
WHERE term = 'RESTful' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A design where the server remembers nothing between requests',
  definition_en = 'An architectural principle where the server does not retain any information about the client between requests. Each request is self-contained.',
  mechanism_en = 'Authentication credentials are sent as tokens with every request. The server has no memory of previous interactions.',
  analogy_en = 'A reception desk that checks your ID every time. No matter how many times you visit, you show your badge (token) each time.',
  pitfall_en = 'Stateless design scales well but requires sending authentication data with every request.'
WHERE term = 'Stateless' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A mechanism for tracking a user''s activity over time',
  definition_en = 'A system that tracks a user''s interactions from login to logout. The server stores state associated with the user during this period.',
  mechanism_en = 'A session ID is stored in a cookie. The server uses this ID to look up the user''s stored session data.',
  analogy_en = 'A hotel stay. From check-in (login) to check-out (logout), you''re assigned a room (session) that''s yours.',
  pitfall_en = 'Sessions consume server memory. They may not scale well for applications with very large user bases.'
WHERE term = 'Session' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'A small piece of data stored in the browser',
  definition_en = 'A small text file that a website stores in the user''s browser. Used for session management, preferences, and tracking.',
  mechanism_en = 'The server sends a Set-Cookie header. The browser stores it and automatically attaches it to subsequent requests to the same domain.',
  analogy_en = 'A membership card. Given by the store (site), you show it on each visit so they recognize you as a returning customer.',
  pitfall_en = 'Never store sensitive data directly in cookies. Use HttpOnly and Secure flags to strengthen cookie security.'
WHERE term = 'Cookie' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'Metadata attached to an HTTP message',
  definition_en = 'Key-value pairs attached to HTTP requests and responses that carry metadata — authentication tokens, content types, caching directives, and more.',
  mechanism_en = 'Formatted as Authorization: Bearer <token> or Content-Type: application/json, among many others.',
  analogy_en = 'The writing on an envelope. Before you open the letter (body), you see the address and sender info (metadata).',
  pitfall_en = 'The old convention of prefixing custom headers with X- is now deprecated. Use plain, descriptive names instead.'
WHERE term = 'Header' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The main data payload of an HTTP message',
  definition_en = 'The primary data section of an HTTP request or response. Contains form submissions, JSON payloads, and other content.',
  mechanism_en = 'The request body carries data to the server; the response body carries data back. JSON is the most common format.',
  analogy_en = 'The contents inside an envelope. The header is the address on the outside; the body is the actual letter.',
  pitfall_en = 'GET requests conventionally have no body. Send data via query parameters for GET requests.'
WHERE term = 'Body' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'The actual data being transmitted',
  definition_en = 'The substantive data within a request or response body. Also refers to the data sent by webhooks or event systems.',
  mechanism_en = 'Typically sent as JSON or XML. For example: { "name": "Taro", "age": 30 }.',
  analogy_en = 'The contents of a package. Strip away the packaging (protocol), and the payload is what you actually want to deliver.',
  pitfall_en = 'Large payloads impact performance. Only send the data that''s actually needed.'
WHERE term = 'Payload' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'An HTTP method for retrieving data',
  definition_en = 'The HTTP method used to read resources. It is safe (doesn''t change server state) and idempotent (repeating it produces the same result).',
  mechanism_en = 'GET /users retrieves all users. GET /users/123 retrieves user #123. Query parameters add filtering and pagination.',
  analogy_en = 'Browsing books in a library. You''re only looking — the books (data) remain unchanged.',
  pitfall_en = 'GET request URLs appear in logs and browser history. Never put sensitive information in query parameters.'
WHERE term = 'GET' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'An HTTP method for creating data',
  definition_en = 'The HTTP method used to create new resources. Data is included in the request body.',
  mechanism_en = 'POST /users creates a new user. The body might contain { "name": "Taro" } with the new resource''s data.',
  analogy_en = 'Donating a new book to the library. You''re adding something new (data) to the collection.',
  pitfall_en = 'POST is not idempotent. Sending the same request multiple times may create duplicate resources.'
WHERE term = 'POST' AND chapter_id = 15;

UPDATE terms SET
  one_liner_en = 'An HTTP method for replacing data',
  definition_en = 'The HTTP method used to update an existing resource by replacing it entirely with new data.',
  mechanism_en = 'PUT /users/123 replaces user #123. The body must contain the complete updated resource.',
  analogy_en = 'Replacing a library book with a newer edition. The old version is swapped out for the new one entirely.',
  pitfall_en = 'PUT replaces the entire resource. To update only specific fields, use PATCH instead.'
WHERE term = 'PUT' AND chapter_id = 15;
