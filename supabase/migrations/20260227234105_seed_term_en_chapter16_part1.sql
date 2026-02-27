/*
  # Seed English translations for Chapter 16 terms (Part 1: terms 1-15)
  
  Chapter 16 covers Advanced Backend, API, and Data concepts.
  Updates the first 15 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'An HTTP method for removing data',
  definition_en = 'The HTTP method used to remove a specified resource. DELETE /users/123 removes user #123.',
  mechanism_en = 'An idempotent operation — sending the same DELETE request multiple times produces the same result (the resource stays deleted).',
  analogy_en = 'Removing a book from the library collection. It''s taken off the shelf permanently.',
  pitfall_en = 'Deletion is irreversible. Consider using soft deletes (a deleted_at flag) instead of actually removing data.'
WHERE term = 'DELETE' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'The four fundamental data operations',
  definition_en = 'Stands for Create, Read, Update, Delete — the four basic operations for working with data.',
  mechanism_en = 'Maps to HTTP methods: POST (Create), GET (Read), PUT/PATCH (Update), DELETE (Delete).',
  analogy_en = 'How you use a notebook. Write (Create), read (Read), rewrite (Update), erase (Delete).',
  pitfall_en = 'Not every API fits neatly into CRUD. Some actions may need different design patterns.'
WHERE term = 'CRUD' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'The types of actions in HTTP requests',
  definition_en = 'Verbs that indicate what action to perform on a resource. Common methods include GET, POST, PUT, PATCH, DELETE, HEAD, and OPTIONS.',
  mechanism_en = 'Combined with a URL to express intent. GET /users means "retrieve the list of users."',
  analogy_en = 'Verbs in a sentence. The URL is the noun ("users"), and the method is the verb ("get," "create," "delete").',
  pitfall_en = 'Use the correct method for each action. Don''t use POST for data retrieval or GET for data modification.'
WHERE term = 'HTTP methods' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A standardized way for systems to communicate',
  definition_en = 'Stands for Application Programming Interface. A defined set of rules and endpoints that allow different software systems to communicate with each other.',
  mechanism_en = 'Send a request in the expected format and receive a structured response. Common styles include REST API and GraphQL.',
  analogy_en = 'An embassy''s service window. The official point of contact for communicating with a foreign system.',
  pitfall_en = 'API changes can break client applications. Use versioning to maintain backward compatibility.'
WHERE term = 'API' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A credential for accessing an API',
  definition_en = 'A secret string required to use an API. It identifies who is making requests and enables usage tracking and billing.',
  mechanism_en = 'Included in request headers or query parameters. The server validates the key before processing the request.',
  analogy_en = 'A building access badge. Without it, you can''t enter (use the API).',
  pitfall_en = 'Never expose API keys publicly. Don''t commit them to GitHub or embed them in frontend code.'
WHERE term = 'API key' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Sending a request to an API',
  definition_en = 'The act of sending an HTTP request to an API endpoint and receiving its response.',
  mechanism_en = 'Made using fetch() or libraries like axios. Executed asynchronously, returning a Promise with the response.',
  analogy_en = 'Making a phone call. You dial the API (send a request) and wait for an answer (response).',
  pitfall_en = 'API calls can fail. Always implement error handling for network issues and unexpected responses.'
WHERE term = 'API call' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'The specific URL for accessing an API feature',
  definition_en = 'A URL that provides access to a specific API resource or function. For example: https://api.example.com/users.',
  mechanism_en = 'Formed by combining a base URL with a path. Paired with an HTTP method to define the exact operation.',
  analogy_en = 'Service windows at an embassy. "Visa applications here," "Inquiries there" — each window handles a different function.',
  pitfall_en = 'Keep endpoint naming consistent. Establish and follow a clear convention across your API.'
WHERE term = 'API endpoint' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'An API designed with REST principles',
  definition_en = 'An API built following the REST architectural style. Uses HTTP methods and resource-oriented URLs. The most common API format in web development.',
  mechanism_en = 'Resources are identified by URLs. Operations use HTTP methods. Data is typically exchanged as JSON.',
  analogy_en = 'An internationally standardized diplomatic protocol. Everyone follows the same well-known rules.',
  pitfall_en = 'Strict RESTfulness isn''t always necessary. Prioritize practical design over theoretical purity.'
WHERE term = 'REST API' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A query language that fetches exactly the data you need',
  definition_en = 'A query language for APIs developed by Facebook. Clients specify exactly which fields they need, and the server returns precisely that — no more, no less.',
  mechanism_en = 'All requests go to a single endpoint. The client sends a query describing the exact shape of the desired data.',
  analogy_en = 'A made-to-order meal. "I want just this part and that part" — you specify exactly what you need.',
  pitfall_en = 'GraphQL has a learning curve. For straightforward APIs, REST is often simpler and sufficient.'
WHERE term = 'GraphQL' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A request for data from a database or API',
  definition_en = 'A structured request to retrieve data from a database or API. In GraphQL, it specifically refers to a read-only data fetch operation.',
  mechanism_en = 'In GraphQL: query { user { name } }. In SQL, the equivalent is a SELECT statement.',
  analogy_en = 'A question. You''re asking the system to look up and return specific information.',
  pitfall_en = 'Complex queries can impact performance. Watch for the N+1 problem and optimize as needed.'
WHERE term = 'Query' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A GraphQL operation that changes data',
  definition_en = 'The GraphQL operation type for creating, updating, or deleting data. Equivalent to POST, PUT, and DELETE in REST.',
  mechanism_en = 'Written as mutation { createUser(name: "Taro") { id } } to execute a data-changing operation.',
  analogy_en = 'A formal request form. "Please create this," "Please update that" — a submitted change request.',
  pitfall_en = 'Any operation with side effects must be a Mutation. Queries should never modify data.'
WHERE term = 'Mutation' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A protocol for two-way real-time communication',
  definition_en = 'A protocol that enables bidirectional, real-time communication between client and server. Used for chat apps, multiplayer games, and live updates.',
  mechanism_en = 'Once a connection is established, both sides can send messages at any time without repeated handshakes. The connection stays open.',
  analogy_en = 'A phone line. Once connected, both parties can speak freely at any time. HTTP, by contrast, is like exchanging letters.',
  pitfall_en = 'WebSocket connections consume resources continuously. Use them only when real-time communication is genuinely needed.'
WHERE term = 'WebSocket' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A connection point for network communication',
  definition_en = 'An abstract endpoint for sending and receiving data over a network. Think of it as a "plug" that establishes a communication channel.',
  mechanism_en = 'Identified by an IP address and port number. Communicates via TCP or UDP protocols.',
  analogy_en = 'An electrical outlet. Plug in (connect) and electricity (data) starts flowing.',
  pitfall_en = 'Libraries like Socket.io simplify implementation. Working with raw sockets is considerably more complex.'
WHERE term = 'Socket' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Instant data delivery with no delay',
  definition_en = 'Communication or processing that delivers data without perceptible delay. Essential for chat, live feeds, online games, and similar applications.',
  mechanism_en = 'Implemented via WebSocket, Server-Sent Events, or polling. The approach depends on the specific use case.',
  analogy_en = 'A live broadcast. Unlike a recording (batch processing), you see events as they happen.',
  pitfall_en = 'Real-time systems are resource-intensive. Evaluate whether true real-time is necessary or if near-real-time suffices.'
WHERE term = 'Real-time' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Automatically receiving updates when data changes',
  definition_en = 'A GraphQL feature that pushes server-side data changes to the client in real time. When data updates, subscribed clients are notified automatically.',
  mechanism_en = 'Typically implemented over WebSocket. Defined as subscription { messageAdded { content } }.',
  analogy_en = 'A newspaper subscription. When a new edition (data update) is published, it''s delivered to you automatically.',
  pitfall_en = 'Active subscriptions consume resources. Unsubscribe when the data is no longer needed.'
WHERE term = 'Real-time Subscription' AND chapter_id = 16;
