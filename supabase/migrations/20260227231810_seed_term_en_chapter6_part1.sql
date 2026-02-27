/*
  # Seed English translations for Chapter 6 terms (part 1 of 2)

  Translates the first 14 terms of Chapter 6.
  Topics: URLs, links, DNS, IP, ports, HTTP, HTTPS, SSL/TLS, protocols.
*/

UPDATE terms SET
  one_liner_en = 'An address on the internet',
  definition_en = 'Stands for Uniform Resource Locator. A string that identifies the location of a resource (web page, image, etc.) on the internet.',
  mechanism_en = 'Structured as protocol://domain:port/path?query#fragment. Example: https://www.example.com:443/path?name=test#section',
  analogy_en = 'A street address. Just as "123 Main St, Apt 4, New York" pinpoints a physical location, a URL pinpoints a resource on the internet.',
  pitfall_en = 'URL and URI are technically different (URI is the broader concept), but in practice they are used almost interchangeably.'
WHERE term = 'URL' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A bridge connecting one page to another',
  definition_en = 'A reference from one web page to another page or resource. Clicking it navigates to the destination.',
  mechanism_en = 'Created with the HTML <a> tag. The href attribute specifies the destination URL. Both text and images can be links.',
  analogy_en = 'A door or gateway. Click it and you move to another room (page).',
  pitfall_en = 'Beware of broken links (404 errors). If the target page is deleted or moved, the link stops working.'
WHERE term = 'Link' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A clickable connection to another page',
  definition_en = 'A link within hypertext that connects one document to another. Clicking it takes you to a different document or resource.',
  mechanism_en = 'A fundamental mechanism of the web. Present since the birth of HTML, it is the origin of the "web" (network) in World Wide Web.',
  analogy_en = 'A warp zone. One click and you teleport anywhere in the world—a magic portal.',
  pitfall_en = '"Link" and "hyperlink" are used almost synonymously. "Hyperlink" is the more formal term.'
WHERE term = 'Hyperlink' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The HTML tag that creates a link',
  definition_en = 'The <a> tag in HTML, used to create hyperlinks. The "a" stands for "anchor."',
  mechanism_en = 'Used as <a href="https://example.com">Link text</a>. Adding target="_blank" opens the link in a new tab.',
  analogy_en = 'A ship''s anchor. It "anchors" to a destination (URL) and creates a signpost pointing there.',
  pitfall_en = 'When using target="_blank", add rel="noopener noreferrer" as a security measure.'
WHERE term = 'Anchor tag' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The attribute that specifies a link''s destination',
  definition_en = 'Stands for Hypertext Reference. An attribute on <a> and <link> tags that specifies the target URL.',
  mechanism_en = 'Used as <a href="https://example.com">Link</a>. Can be a relative or absolute path.',
  analogy_en = 'A signpost with a destination written on it. "Tokyo Station this way" tells you exactly where the link goes.',
  pitfall_en = 'An empty href or just # causes the page to jump to the top. Watch out for unintended behavior.'
WHERE term = 'Href' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A dynamic value embedded in the URL path',
  definition_en = 'A dynamic value embedded in the path portion of a URL. Used to identify a specific resource.',
  mechanism_en = 'In /users/123, the 123 is a path parameter. In API design, it is often defined as /users/:id.',
  analogy_en = 'An apartment number. In "Oak Apartments / Room 301," 301 is the path parameter.',
  pitfall_en = 'Know when to use path parameters vs. query parameters. Paths identify resources; queries filter or search.'
WHERE term = 'Path parameter' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'Extra information added after the ? in a URL',
  definition_en = 'Parameters appended to the end of a URL, starting with ? and written as key=value pairs. Multiple pairs are joined with &.',
  mechanism_en = 'Format: ?name=test&age=20. Used to pass search terms, filters, page numbers, and other options.',
  analogy_en = 'Options on a food order. "Ramen? Extra firm noodles & extra scallions"—additional preferences attached to the request.',
  pitfall_en = 'Never put sensitive information in query strings. URLs are easily logged and visible to others.'
WHERE term = 'Query string' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A single key=value pair in a query string',
  definition_en = 'One individual parameter within a query string. A single key=value pair like name=test.',
  mechanism_en = 'In ?name=test&age=20, both name=test and age=20 are separate query parameters.',
  analogy_en = 'One line item on an order form. "Name: Yamada" and "Age: 20" are each a query parameter.',
  pitfall_en = 'If a value contains special characters (&, =, spaces), it must be URL-encoded.'
WHERE term = 'Query parameter' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A prefix added before the main domain name',
  definition_en = 'A name prepended to the main domain to categorize or distinguish parts of a site. Common examples: www, blog, api.',
  mechanism_en = 'In blog.example.com, "blog" is the subdomain. One domain can host multiple services using subdomains.',
  analogy_en = 'Department names within a company. "Acme Corp Sales" and "Acme Corp Engineering" share the same company but are different departments.',
  pitfall_en = '"www" is actually a subdomain. www.example.com and example.com are technically different addresses.'
WHERE term = 'Subdomain' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The system that translates domain names to IP addresses',
  definition_en = 'Stands for Domain Name System. A system that converts human-readable domain names into computer-friendly IP addresses.',
  mechanism_en = 'When you type a URL in a browser, it queries a DNS server to get the IP address, then connects to that server.',
  analogy_en = 'A phone book. Look up a name (domain) and you get a phone number (IP address).',
  pitfall_en = 'DNS changes take time to propagate (hours to 48 hours). Understand the concept of TTL (cache duration).'
WHERE term = 'DNS' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A computer''s numeric address on a network',
  definition_en = 'Stands for Internet Protocol address. A numeric label that identifies a computer on a network.',
  mechanism_en = 'IPv4 uses a format like 192.168.1.1 (32 bits); IPv6 uses a format like 2001:0db8:... (128 bits).',
  analogy_en = 'A phone number. A sequence of digits that uniquely identifies any computer worldwide.',
  pitfall_en = 'Understand the difference between private and public IPs. A home network''s private IP is not visible from outside.'
WHERE term = 'IP address' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'A number that identifies a specific service on a computer',
  definition_en = 'A number (0–65535) used to distinguish between multiple services running on a single computer.',
  mechanism_en = 'HTTP uses port 80, HTTPS uses 443, and development servers commonly use 3000 or 8080.',
  analogy_en = 'An apartment number within a building. The building address (IP) is the same, but the apartment number (port) directs to a specific unit.',
  pitfall_en = 'Well-known ports (0–1023) require special permissions. Development typically uses ports above 1024.'
WHERE term = 'Port' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'The communication rules for fetching web pages',
  definition_en = 'Stands for HyperText Transfer Protocol. The communication protocol used to exchange data between web browsers and web servers.',
  mechanism_en = 'A client sends a request and a server returns a response. Methods include GET, POST, PUT, DELETE.',
  analogy_en = 'The rules for sending letters. "Write the address here," "put the stamp here"—agreed conventions for communication.',
  pitfall_en = 'HTTP is not encrypted. Use HTTPS when handling passwords or other sensitive data.'
WHERE term = 'HTTP' AND chapter_id = 6;

UPDATE terms SET
  one_liner_en = 'HTTP with encryption added',
  definition_en = 'Stands for HTTP Secure. HTTP enhanced with encryption (SSL/TLS) so that communication cannot be read by third parties.',
  mechanism_en = 'An SSL/TLS certificate verifies the server''s identity and encrypts the connection. URLs start with https://.',
  analogy_en = 'A sealed envelope. A postcard (HTTP) can be read by anyone, but a sealed letter (HTTPS) keeps its contents private.',
  pitfall_en = 'HTTPS is not a guarantee of complete safety. Phishing sites can also use HTTPS.'
WHERE term = 'HTTPS' AND chapter_id = 6;
