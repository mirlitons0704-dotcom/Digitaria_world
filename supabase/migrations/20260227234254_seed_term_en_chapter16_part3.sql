/*
  # Seed English translations for Chapter 16 terms (Part 3: terms 31-45)
  
  Continues Chapter 16 Advanced Backend, API, and Data concepts.
  Updates the final 15 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'A lightweight data format for exchanging information',
  definition_en = 'Stands for JavaScript Object Notation. A human-readable and machine-readable data format that has become the standard for API communication.',
  mechanism_en = 'Uses { "key": "value" } format. Supports arrays, objects, strings, numbers, booleans, and null.',
  analogy_en = 'A universal language. Understood by virtually every programming language — the lingua franca of data exchange.',
  pitfall_en = 'Keys in JSON must use double quotes. Single quotes or unquoted keys will cause a parse error.'
WHERE term = 'JSON' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A tag-based data format',
  definition_en = 'Stands for Extensible Markup Language. A structured data format using opening and closing tags. Used in older APIs (SOAP) and configuration files.',
  mechanism_en = 'Data is wrapped in <tag>content</tag> format. Attributes can be added to tags. Stricter rules than HTML.',
  analogy_en = 'A formal document. The formatting is rigidly prescribed, like an official government form.',
  pitfall_en = 'XML is more verbose and harder to work with than JSON. JSON is the preferred choice for new projects.'
WHERE term = 'XML' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Converting data into a transmittable format',
  definition_en = 'The process of converting an object or data structure into a format that can be stored or transmitted — like a JSON string.',
  mechanism_en = 'JSON.stringify() converts a JavaScript object to a JSON string. The reverse process is called deserialization.',
  analogy_en = 'Packing for shipment. You take a complex item (object) and pack it into a shipping-friendly format (string).',
  pitfall_en = 'Circular references (objects that reference themselves) cannot be serialized. Watch your data structures.'
WHERE term = 'Serialization' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Converting a transmitted format back into data',
  definition_en = 'The reverse of serialization — converting a stored or transmitted string back into a usable object or data structure.',
  mechanism_en = 'JSON.parse() converts a JSON string back into a JavaScript object. Used when processing API responses.',
  analogy_en = 'Unpacking a delivery. Open the package (string) and take out the contents (object).',
  pitfall_en = 'Deserializing untrusted data is a security risk. Always validate the data before using it.'
WHERE term = 'Deserialization' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Storing data temporarily for faster access',
  definition_en = 'A mechanism that temporarily stores frequently accessed data so subsequent requests can be served faster without hitting the original source.',
  mechanism_en = 'Implemented at multiple layers: browser cache, CDN cache, and server-side cache. Each layer speeds up different types of access.',
  analogy_en = 'Keeping frequently used books on your desk. No need to walk to the bookshelf (database) every time.',
  pitfall_en = 'Stale caches serve outdated data. A proper cache invalidation strategy is essential.'
WHERE term = 'Cache' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A global network that delivers content from nearby servers',
  definition_en = 'Stands for Content Delivery Network. A distributed network of servers placed worldwide that serves content from the location closest to the user.',
  mechanism_en = 'Content from the origin server is cached on edge servers. Users receive data from whichever edge server is nearest.',
  analogy_en = 'A convenience store chain. Instead of going to headquarters (origin), you pick up what you need at the nearest branch (edge).',
  pitfall_en = 'Be careful with caching dynamic or user-specific content. Personal data should never be served from a shared cache.'
WHERE term = 'CDN' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'The delay between sending and receiving data',
  definition_en = 'The time elapsed between sending a request and receiving a response. Measured in milliseconds (ms).',
  mechanism_en = 'Affected by network distance, server processing time, and data size. CDNs and optimization reduce latency.',
  analogy_en = 'The delay on an international phone call. There''s a slight gap between speaking and being heard.',
  pitfall_en = 'Latency can never reach zero. Aim to optimize it to the point where users don''t notice the delay.'
WHERE term = 'Latency' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Distributing requests across multiple servers',
  definition_en = 'Spreading incoming requests across multiple servers so no single server becomes overloaded.',
  mechanism_en = 'A load balancer distributes traffic using algorithms like round-robin or least-connections.',
  analogy_en = 'Bank teller windows with a number system. Customers are directed to available windows to keep wait times even.',
  pitfall_en = 'Session management needs care. Design so the same user can hit different servers without issues (stateless design).'
WHERE term = 'Load balancing' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Splitting large data sets into pages',
  definition_en = 'Returning large data sets in smaller chunks (pages) rather than all at once. Balances performance with usability.',
  mechanism_en = 'Controlled with limit (items per page) and offset (starting position), or cursor-based pagination for better performance.',
  analogy_en = 'Borrowing books 10 at a time from the library. You can''t carry them all at once, so you take them in batches.',
  pitfall_en = 'Offset-based pagination slows down with large data sets. Cursor-based pagination is more efficient at scale.'
WHERE term = 'Pagination (API)' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Managing different versions of an API',
  definition_en = 'A strategy for maintaining backward compatibility while evolving an API. Lets old and new versions coexist.',
  mechanism_en = 'Common approach: include the version in the URL path, like /v1/users and /v2/users.',
  analogy_en = 'Amending laws. Old laws remain valid while new ones are added, giving time to transition.',
  pitfall_en = 'Too many versions become a maintenance burden. Plan to retire old versions on a schedule.'
WHERE term = 'API Versioning' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Marking old features as "please stop using this"',
  definition_en = 'Flagging an old API or feature as scheduled for removal, encouraging users to migrate to the newer alternative.',
  mechanism_en = 'Communicated through documentation and response headers. After a transition period, the deprecated feature is removed.',
  analogy_en = 'A store closing notice. "This location closes next month. Please visit our new shop next door."',
  pitfall_en = 'Continuing to use deprecated APIs is risky. Migrate to the replacement during the transition window.'
WHERE term = 'Deprecation' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'An operation that produces the same result no matter how many times it runs',
  definition_en = 'A property where repeating the same request produces the same outcome. GET, PUT, and DELETE are idempotent; POST is not.',
  mechanism_en = 'Sending DELETE /users/123 multiple times always results in the same state: user 123 is deleted.',
  analogy_en = 'Flipping a light switch to "off." No matter how many times you flip it off, the result is the same — the light stays off.',
  pitfall_en = 'Be cautious when retrying non-idempotent operations (like POST). You may create duplicates without a deduplication mechanism.'
WHERE term = 'Idempotent' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Automatically trying again after a failure',
  definition_en = 'A pattern where failed API requests are automatically re-attempted. Handles transient network issues gracefully.',
  mechanism_en = 'Uses exponential backoff (1s, 2s, 4s...) between retries, with a maximum retry count to prevent infinite loops.',
  analogy_en = 'Redialing a busy phone number. If it doesn''t connect, wait a moment and try again.',
  pitfall_en = 'Too many retries can overload the server. Always set a maximum retry count and appropriate intervals.'
WHERE term = 'Retry' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A backup plan when the primary method fails',
  definition_en = 'An alternative approach used when the primary method fails. Examples include returning cached data or using default values.',
  mechanism_en = 'Errors are caught with try-catch, and the fallback logic executes when the primary path fails.',
  analogy_en = 'An emergency exit. When the main exit is blocked, there''s an alternate route to safety.',
  pitfall_en = 'Fallbacks can fail too. Design multiple layers of fallback for critical systems.'
WHERE term = 'Fallback' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A document explaining how to use an API',
  definition_en = 'Documentation describing an API''s endpoints, parameters, response formats, error codes, and authentication. Can be auto-generated with tools like Swagger/OpenAPI.',
  mechanism_en = 'Includes endpoint listings, request/response examples, error codes, and authentication instructions.',
  analogy_en = 'A product manual. Detailed instructions on how to use the product (API) correctly.',
  pitfall_en = 'Keep documentation in sync with the actual implementation. Outdated docs cause confusion and wasted time.'
WHERE term = 'API Documentation' AND chapter_id = 16;
