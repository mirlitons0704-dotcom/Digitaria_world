/*
  # Seed English translations for Chapter 17 / Epilogue terms (Part 2: terms 11-20)
  
  Continues Chapter 17 (Epilogue) miscellaneous and advanced concepts.
  Updates the remaining 10 terms with English translations.
*/

UPDATE terms SET
  one_liner_en = 'The four layers that make up every HTML element',
  definition_en = 'Every HTML element consists of four nested layers: content (the actual stuff), padding (inner spacing), border (the edge), and margin (outer spacing).',
  mechanism_en = 'With box-sizing: border-box;, the width includes padding and border. This makes sizing calculations much simpler.',
  analogy_en = 'A gift box. The gift (content), cushioning (padding), the box itself (border), and the space between boxes (margin).',
  pitfall_en = 'The default box-sizing is content-box. Most projects set border-box globally in their reset CSS for easier calculations.'
WHERE term = 'Box model' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Designing layouts that adapt to any screen size',
  definition_en = 'A design approach where layouts automatically adjust to fit different screen sizes — desktops, tablets, and phones.',
  mechanism_en = 'Uses media queries (@media) to set breakpoints. In Tailwind, responsive prefixes like md: and lg: apply styles at specific widths.',
  analogy_en = 'Water taking the shape of its container. The layout flows and adapts naturally to whatever screen it''s in.',
  pitfall_en = 'Designing mobile-first makes it easier to scale up to larger screens later.'
WHERE term = 'Responsive design' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'The screen width where a layout changes',
  definition_en = 'A specific screen width at which the layout switches to a different configuration. Common breakpoints include 640px, 768px, and 1024px.',
  mechanism_en = 'Defined with @media (min-width: 768px) { } to apply styles above that width.',
  analogy_en = 'A transformation trigger. When the screen crosses this width, the layout transforms.',
  pitfall_en = 'Don''t confuse CSS breakpoints with debugger breakpoints. The term is the same but the context is different.'
WHERE term = 'Breakpoint (CSS)' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Numbers that indicate request outcomes',
  definition_en = 'Three-digit codes returned by the server indicating the result of a request. 200 means success, 404 means not found, 500 means server error.',
  mechanism_en = '1xx: informational. 2xx: success. 3xx: redirect. 4xx: client error. 5xx: server error.',
  analogy_en = 'A medical diagnosis code. "Healthy (200)," "Not found (404)," "Our fault (500)."',
  pitfall_en = '4xx errors are client-side problems; 5xx errors are server-side. Use the code to quickly identify where the issue lies.'
WHERE term = 'Status code (404/500)' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Publishing an app so real users can access it',
  definition_en = 'The process of placing your application on a production server and making it available to users.',
  mechanism_en = 'Typically: build the project, upload to a server, and go live. Platforms like Vercel and Netlify auto-deploy on Git push.',
  analogy_en = 'Opening a shop. After all the preparation, you finally welcome customers.',
  pitfall_en = 'Test thoroughly before deploying. Problems in production affect real users.'
WHERE term = 'Deploy' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'A service that makes websites available on the internet',
  definition_en = 'A server service that stores and serves your website or application files, making them accessible to anyone on the internet.',
  mechanism_en = 'Providers include Vercel, Netlify, AWS, and traditional hosting. Options range from static site hosting to full server environments.',
  analogy_en = 'Renting a storefront. You place your products (site) there so customers (users) can visit.',
  pitfall_en = 'Free plans have limitations on traffic and features. Consider paid plans as your project grows.'
WHERE term = 'Hosting' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'A human-readable address for a website',
  definition_en = 'A name like example.com that identifies a website. Easier for humans to remember than raw IP addresses.',
  mechanism_en = 'DNS translates domain names to IP addresses. Custom domains are purchased and configured to point to your server.',
  analogy_en = 'A shop''s sign. The address (IP) is hard to remember, but the name (domain) sticks in your mind.',
  pitfall_en = 'Domains are first-come, first-served. Register desired names early. Annual renewal fees apply.'
WHERE term = 'Domain' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Encrypting web traffic for security',
  definition_en = 'SSL/TLS certificates encrypt the communication between browser and server. Websites using it show https:// and a lock icon in the address bar.',
  mechanism_en = 'Encrypts data in transit to prevent eavesdropping and tampering. Free certificates are available through Let''s Encrypt.',
  analogy_en = 'A sealed, coded letter. Even if someone intercepts it, they can''t read the contents.',
  pitfall_en = 'HTTPS is mandatory for modern websites. Browsers display "Not Secure" warnings for plain HTTP sites.'
WHERE term = 'SSL / HTTPS' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Optimizing a site to rank higher in search results',
  definition_en = 'Stands for Search Engine Optimization. The practice of improving a website so it appears higher in Google and other search engine results.',
  mechanism_en = 'Key factors: proper page titles, meta descriptions, structured data, fast loading, and mobile compatibility.',
  analogy_en = 'Making a shop easier to find. Better signage, accurate map listings, and a visible storefront.',
  pitfall_en = 'Don''t sacrifice user experience for SEO. Quality content is the most important ranking factor.'
WHERE term = 'SEO' AND chapter_id = 17;

UPDATE terms SET
  one_liner_en = 'Making products usable by everyone',
  definition_en = 'The practice of ensuring websites and applications can be used by all people, including those with disabilities. Abbreviated as a11y.',
  mechanism_en = 'Involves semantic HTML, ARIA attributes, keyboard navigation support, sufficient color contrast, and alt text for images.',
  analogy_en = 'Universal building design. Ramps, elevators, and Braille signage ensure everyone can enter and navigate.',
  pitfall_en = 'Accessibility should be designed in from the start, not added as an afterthought.'
WHERE term = 'Accessibility' AND chapter_id = 17;
