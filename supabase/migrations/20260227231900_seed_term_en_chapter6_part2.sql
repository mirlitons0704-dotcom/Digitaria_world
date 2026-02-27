/*
  # Seed English translations for Chapter 6 terms (part 2 of 2)

  Translates the remaining 14 terms of Chapter 6.
  Topics: SSL/TLS, protocols, HTTP methods, status codes, RSS, SMTP,
  egress, ingress.
*/

UPDATE terms SET
  one_liner_en = 'Technology that encrypts internet communication',
  definition_en = 'Stands for Secure Sockets Layer / Transport Layer Security. Security technology that encrypts internet communication.',
  mechanism_en = 'Uses public-key cryptography to encrypt data in transit. Certificates verify the server''s identity and prevent man-in-the-middle attacks.',
  analogy_en = 'Invisible ink and special glasses. A letter written in invisible ink (encryption) can only be read with special glasses (the decryption key).',
  pitfall_en = 'SSL is outdated and has known vulnerabilities; TLS is the modern replacement. However, the term "SSL certificate" persists by convention.'
WHERE term = 'SSL/TLS' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The rules that govern how computers communicate',
  definition_en = 'A set of rules that computers follow when communicating. Many types exist: HTTP, HTTPS, FTP, SMTP, and more.',
  mechanism_en = 'Protocols define data format, transmission procedures, and error handling. Both parties must follow the same protocol for communication to work.',
  analogy_en = 'A shared language or etiquette. Japanese speakers use Japanese; English speakers use English—the agreed-upon convention makes conversation possible.',
  pitfall_en = 'Choose the right protocol for the job. Web traffic uses HTTP/HTTPS; email uses SMTP/POP3/IMAP.'
WHERE term = 'Protocol' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A message asking the server for something',
  definition_en = 'A message sent from a client (such as a browser) to a server. Examples: "send me this page" or "save this data."',
  mechanism_en = 'Composed of an HTTP method (GET, POST, etc.), URL, headers, and body. The server processes it and returns a response.',
  analogy_en = 'Ordering at a restaurant. "One curry, please" (request)—then the kitchen delivers the dish (response).',
  pitfall_en = 'Use the right method: GET to retrieve data, POST to create, PUT to update, DELETE to remove.'
WHERE term = 'Request' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The server''s reply to a request',
  definition_en = 'The answer a server sends back after receiving a client''s request. Composed of a status code, headers, and a body (the actual data).',
  mechanism_en = 'Returns the result of processing the request. Success uses 200-series codes; errors use 400-series or 500-series codes.',
  analogy_en = 'The dish served after you order. Your request is fulfilled and the result is handed back.',
  pitfall_en = 'Slow responses degrade user experience. Understanding performance optimization is important.'
WHERE term = 'Response' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'Success! Everything went fine',
  definition_en = 'The HTTP status code indicating that a request was processed successfully. The most basic success response.',
  mechanism_en = 'For a GET request, the requested data is returned. For a POST, it means the operation completed.',
  analogy_en = '"Got it!" The dish came out exactly as ordered.',
  pitfall_en = 'A 200 status doesn''t guarantee the content is what you expected. Always check the response body too.'
WHERE term = '200 OK' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The request was malformed',
  definition_en = 'A status code indicating a problem with the client''s request—syntax errors, invalid parameters, or malformed data.',
  mechanism_en = 'Common causes: missing required parameters, invalid JSON, or values in the wrong format.',
  analogy_en = '"Your order doesn''t make sense." Like ordering something not on the menu or in a language the server can''t understand.',
  pitfall_en = 'When you see a 400 error, inspect the request. Compare it against the API documentation.'
WHERE term = '400 Bad Request' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'Authentication required',
  definition_en = 'A status code indicating that the request requires authentication credentials, which are either missing or invalid.',
  mechanism_en = 'Triggered when a user is not logged in, the token has expired, or the credentials are incorrect.',
  analogy_en = '"Please show your membership card." Entry requires a ticket (authentication), but you don''t have one.',
  pitfall_en = '401 vs. 403: 401 means "I don''t know who you are" (not authenticated); 403 means "I know who you are, but you''re not allowed" (not authorized).'
WHERE term = '401 Unauthorized' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'You don''t have permission to access this',
  definition_en = 'A status code indicating that the user is authenticated but lacks the necessary permissions for the requested resource.',
  mechanism_en = 'Occurs when a regular user tries to access an admin-only page, for example.',
  analogy_en = '"Staff only beyond this point." You have an ID badge (authentication), but you don''t have clearance for this area.',
  pitfall_en = 'When you see 403, check permissions. Verify that the correct role is assigned.'
WHERE term = '403 Forbidden' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The requested page was not found',
  definition_en = 'A status code indicating that the resource at the specified URL does not exist. The most well-known error code.',
  mechanism_en = 'Caused by URL typos, deleted pages, relocated content, or broken links.',
  analogy_en = '"Nothing at this address." Like visiting a house that has been demolished or an address that never existed.',
  pitfall_en = '404 pages can be customized. Providing a user-friendly 404 page improves the experience.'
WHERE term = '404 Not Found' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'Something went wrong on the server',
  definition_en = 'A status code indicating that an unexpected error occurred inside the server. This is a server-side problem.',
  mechanism_en = 'Caused by bugs in the code, database connection failures, configuration errors, and other server-side issues.',
  analogy_en = '"An accident in the kitchen." Your order was fine, but a problem in the kitchen (server) prevents the dish from being served.',
  pitfall_en = 'A 500 error is never the user''s fault. Developers should check the server logs to identify the cause.'
WHERE term = '500 Internal Server Error' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A feed that delivers site updates automatically',
  definition_en = 'Stands for Really Simple Syndication. An XML-based format for distributing update notifications from blogs and news sites.',
  mechanism_en = 'An RSS reader periodically fetches RSS feeds and displays new articles in a unified view, aggregating updates from multiple sites.',
  analogy_en = 'A newspaper subscription. Updates arrive automatically instead of you visiting each site individually.',
  pitfall_en = 'RSS usage has declined with the rise of social media, but it is still widely used for tech blogs and news aggregation.'
WHERE term = 'RSS' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The protocol for sending email',
  definition_en = 'Stands for Simple Mail Transfer Protocol. The communication protocol used for sending electronic mail.',
  mechanism_en = 'Used to transfer mail from a client to a server, or between servers. Receiving mail uses POP3 or IMAP instead.',
  analogy_en = 'The postal delivery system. It''s the set of rules for getting a letter (email) to the post office (server). Picking up mail uses a different system.',
  pitfall_en = 'SMTP is for sending only. Receiving requires POP3 (download-based) or IMAP (sync-based).'
WHERE term = 'SMTP' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'Outbound traffic—data leaving the network',
  definition_en = 'Communication or data flowing outward from a network. For example, data sent from a server to a client.',
  mechanism_en = 'Cloud services often charge for egress (outbound data transfer). Firewalls can also be configured to control egress.',
  analogy_en = 'The exit of a building. Data going out (leaving the network).',
  pitfall_en = 'Watch egress costs on cloud platforms. Sending large volumes of data outward can become expensive.'
WHERE term = 'Egress' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'Inbound traffic—data entering the network',
  definition_en = 'Communication or data flowing inward from outside the network. For example, requests arriving at a server from clients.',
  mechanism_en = 'In Kubernetes, an Ingress resource controls how external traffic reaches services inside the cluster.',
  analogy_en = 'The entrance of a building. Data coming in (entering the network).',
  pitfall_en = 'In Kubernetes, "Ingress" (capitalized) is a specific resource type. Context determines whether the general or Kubernetes meaning applies.'
WHERE term = 'Ingress' AND chapter_id = 6;
