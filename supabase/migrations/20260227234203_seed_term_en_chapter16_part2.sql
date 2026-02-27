/*
  # Seed English translations for Chapter 16 terms (Part 2: terms 16-30)
  
  Continues Chapter 16 Advanced Backend, API, and Data concepts.
  Updates terms 16-30 with English translations.
*/

UPDATE terms SET
  one_liner_en = 'A system that sends notifications when events happen',
  definition_en = 'A mechanism that automatically sends an HTTP request to a specified URL when a particular event occurs. Also called a reverse API or HTTP callback.',
  mechanism_en = 'When an event triggers (payment completed, code pushed, form submitted), a POST request is sent to the registered URL.',
  analogy_en = 'A "call me when it happens" agreement. "When the payment goes through, notify me at this number (URL)."',
  pitfall_en = 'Always authenticate incoming webhooks. Without verification, anyone could send fake requests to your endpoint.'
WHERE term = 'Webhook' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A function that runs after another operation completes',
  definition_en = 'A function passed as an argument to another function, intended to be called when that operation finishes. A foundational pattern for handling asynchronous results.',
  mechanism_en = 'Pass a function as an argument: fetchData(data => console.log(data)). The function executes when data arrives.',
  analogy_en = '"Call me when you''re done." You hand off a task and get a callback (phone call) when it''s completed.',
  pitfall_en = 'Beware of callback hell — deeply nested callbacks become unreadable. Use Promises or async/await instead.'
WHERE term = 'Callback' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A unique identifier for tracking a callback',
  definition_en = 'A unique identifier used to match a response to its original request when multiple asynchronous operations are in flight.',
  mechanism_en = 'Assigned when a request is sent and returned with the response. Used to track and correlate async operations.',
  analogy_en = 'A ticket number. "Number 123, your order is ready" — you know it''s yours by the matching number.',
  pitfall_en = 'IDs must be guaranteed unique. Use UUIDs or similar systems to prevent collisions.'
WHERE term = 'Callback ID' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'The act of calling a function or API',
  definition_en = 'The act of executing a function or triggering an API. Also used to count executions, such as Lambda function invocations for billing purposes.',
  mechanism_en = 'The parentheses in myFunction() are what perform the invocation — they execute the function.',
  analogy_en = 'Casting a spell. The invocation activates the function and triggers its effect.',
  pitfall_en = 'In serverless platforms, you''re often billed per invocation. Minimize unnecessary calls to control costs.'
WHERE term = 'Invocation' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A cap on how often an API can be called',
  definition_en = 'A limit on the number of API requests allowed within a given time window. Protects servers from overload and enforces plan-based quotas.',
  mechanism_en = 'For example: 60 requests per minute, or 1,000 per day. Exceeding the limit returns HTTP 429 (Too Many Requests).',
  analogy_en = 'Admission limits. "Maximum 100 people per hour" keeps the venue from getting overcrowded.',
  pitfall_en = 'When rate-limited, space out retries. Exponential backoff (1s, 2s, 4s...) is the standard approach.'
WHERE term = 'Rate limit' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Intentionally slowing down request processing',
  definition_en = 'Deliberately limiting the rate at which requests are processed. Used to protect servers and control API usage.',
  mechanism_en = 'Only allows execution at fixed intervals. Excess requests are either queued or rejected.',
  analogy_en = 'Turning down the faucet. Restricting the flow of water (requests) so the sink doesn''t overflow.',
  pitfall_en = 'Don''t confuse throttle with debounce. Throttle executes at regular intervals; debounce waits and executes only the last call.'
WHERE term = 'Throttling' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Grouping rapid-fire events into one action',
  definition_en = 'A technique that waits for a burst of rapid events to stop, then executes only once. Commonly used to optimize search-as-you-type features.',
  mechanism_en = 'After an event fires, a timer starts. If a new event fires before the timer expires, the timer resets. Execution happens only after the pause.',
  analogy_en = 'An elevator door. It keeps waiting as people board. Once no one else enters, it finally closes.',
  pitfall_en = 'Too long a delay makes the interface feel sluggish. Around 300ms is a good default for most use cases.'
WHERE term = 'Debouncing' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Cutting off a request that takes too long',
  definition_en = 'Canceling a request or operation that hasn''t responded within a set time limit, preventing indefinite waiting.',
  mechanism_en = 'Set a timeout duration when making requests. If no response arrives in time, the operation is treated as a failure.',
  analogy_en = 'A meeting-up rule: "If you''re not here in 30 minutes, I''m leaving." You don''t wait forever.',
  pitfall_en = 'Timeouts that are too short may kill legitimate slow requests. Set appropriate values based on expected response times.'
WHERE term = 'Timeout' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A mechanism for allowing cross-domain requests',
  definition_en = 'Stands for Cross-Origin Resource Sharing. A browser security feature that controls which domains can make requests to your server.',
  mechanism_en = 'The server includes an Access-Control-Allow-Origin header to specify which origins are permitted to make requests.',
  analogy_en = 'An entry visa. "Visitors from this country (origin) are welcome" — declared by the server.',
  pitfall_en = 'CORS errors are one of the most common frustrations during development. The fix is always on the server side.'
WHERE term = 'CORS' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A toolkit for building on a specific platform',
  definition_en = 'Stands for Software Development Kit. A bundled set of tools, libraries, and documentation for building applications on a specific platform or service.',
  mechanism_en = 'Instead of making raw API calls, you use SDK functions that handle the details. Authentication and common tasks are simplified.',
  analogy_en = 'A meal kit. Ingredients, seasonings, and a recipe all in one package — making development (cooking) much easier.',
  pitfall_en = 'Keep SDKs updated. Outdated versions can introduce security vulnerabilities.'
WHERE term = 'SDK' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Verifying who a user is',
  definition_en = 'The process of confirming a user''s identity — proving they are who they claim to be. Uses passwords, biometrics, tokens, or other credentials.',
  mechanism_en = 'Credentials are validated at login. On success, a session or token is issued for subsequent requests.',
  analogy_en = 'A passport check. "Are you really who you say you are?" — confirming identity.',
  pitfall_en = 'Authentication and authorization are different. Authentication is "who are you?" Authorization is "what can you do?"'
WHERE term = 'Authentication' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'Checking what a user is allowed to do',
  definition_en = 'The process of determining whether an authenticated user has permission to access a specific resource or perform a specific action.',
  mechanism_en = 'Checks roles (admin, user, etc.) or permissions. Returns HTTP 403 (Forbidden) if the user lacks authorization.',
  analogy_en = 'A VIP pass. Having a passport (authentication) doesn''t mean you can enter the VIP area — you need separate permission.',
  pitfall_en = 'Authorization checks must happen server-side. Frontend-only checks are easily bypassed.'
WHERE term = 'Authorization' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'An encrypted string representing a user''s identity',
  definition_en = 'An encoded string that represents a user''s authentication status. JWT is the most common format. Sent with requests so the server can verify identity.',
  mechanism_en = 'Issued upon successful login. Included in the Authorization header of subsequent requests for server-side validation.',
  analogy_en = 'A pass card. With this card, you don''t need to show your full passport (re-login) every time.',
  pitfall_en = 'Set appropriate token expiration times. Too long is a security risk; too short is inconvenient for users.'
WHERE term = 'Token' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A self-contained, JSON-based token format',
  definition_en = 'Stands for JSON Web Token. A compact token format with three parts: header, payload, and signature. The signature enables tamper detection.',
  mechanism_en = 'Three Base64-encoded sections joined by dots. The signature verifies that the token hasn''t been altered.',
  analogy_en = 'A sealed letter. The contents (payload) come with a seal (signature) — if the seal is broken, you know it was tampered with.',
  pitfall_en = 'The payload is encoded, not encrypted — anyone can read it. Never put sensitive data in the payload.'
WHERE term = 'JWT' AND chapter_id = 16;

UPDATE terms SET
  one_liner_en = 'A framework for delegating access to third-party services',
  definition_en = 'An authorization framework that lets users grant third-party services limited access to their data. Powers "Sign in with Google" and similar flows.',
  mechanism_en = 'User approves access, an authorization code is issued, which is exchanged for an access token, enabling API access on the user''s behalf.',
  analogy_en = 'A power of attorney. "I authorize this service to act on my behalf for these specific things."',
  pitfall_en = 'OAuth is for authorization, not authentication. For authentication, combine it with OpenID Connect.'
WHERE term = 'OAuth' AND chapter_id = 16;
