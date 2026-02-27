/*
  # Seed English translations for Chapter 1 terms

  Translates all 5 English fields (one_liner_en, definition_en, mechanism_en,
  analogy_en, pitfall_en) for the 10 terms in Chapter 1:
  Binary, Bit, Byte, ASCII, Machine language, Code, Program, App, Software, File.

  Translations are written as natural English explanations faithful to the
  original Japanese content.
*/

UPDATE terms SET
  one_liner_en = 'A way to represent numbers using only 0 and 1',
  definition_en = 'The number system computers use to represent data. While humans normally use 10 digits (0–9) in the decimal system, computers can only distinguish between electrical ON and OFF states, so they express everything using just two digits: 0 and 1.',
  mechanism_en = 'An electrical current flowing is represented as "1," and no current as "0." By combining these two states, computers can represent numbers, text, images, music, and all other forms of data. For example, the decimal number 5 becomes 101 in binary.',
  analogy_en = 'Think of Morse code, which uses just dots and dashes. With only two types of signals, you can convey any message—binary works on the same principle.',
  pitfall_en = 'It''s tempting to think binary is outdated technology. In reality, every modern device—from smartphones to supercomputers—fundamentally runs on binary.'
WHERE term = 'Binary' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'The smallest unit of information—a single 0 or 1',
  definition_en = 'Short for "binary digit." It is the smallest unit of data a computer can handle, holding a value of either 0 or 1.',
  mechanism_en = 'A single bit can only represent two possibilities: 0 or 1. But adding more bits doubles the number of possible values each time. Two bits give you 4 combinations (00, 01, 10, 11), three bits give you 8, and so on.',
  analogy_en = 'Like a single light switch—it''s either ON or OFF. One bit records exactly one yes-or-no answer, making it the smallest possible unit of information.',
  pitfall_en = 'Bits and bytes are easy to confuse. A bit is the smallest unit; a byte is a group of 8 bits. Network speeds are usually measured in bps (bits per second), while file sizes are measured in bytes.'
WHERE term = 'Bit' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'A group of 8 bits—roughly one character''s worth of data',
  definition_en = 'A unit made up of 8 bits bundled together. It serves as the standard unit for measuring data size in computing. One byte can represent 256 different values (2 to the power of 8).',
  mechanism_en = 'With 8 bits, you can represent numbers from 0 to 255 or a single alphabet character. File sizes are expressed in KB (kilobytes, about 1,000 bytes), MB (megabytes, about 1 million bytes), and GB (gigabytes, about 1 billion bytes).',
  analogy_en = 'If a bit is a single LEGO brick, a byte is a basic building block made of 8 bricks. You combine these building blocks to create larger structures (data).',
  pitfall_en = 'Network speed "Mbps" stands for mega-bits per second, while file size "MB" stands for mega-bytes. Since there are 8 bits in a byte, the difference is eightfold—an important distinction.'
WHERE term = 'Byte' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'A standard table that maps characters to numbers',
  definition_en = 'Stands for American Standard Code for Information Interchange. It is a character encoding standard that assigns a number between 0 and 127 to each character.',
  mechanism_en = 'For example, "A" is assigned 65, "B" is 66, and "a" is 97. Letters, digits, and symbols each get a designated number. Internally, computers exchange these numbers (converted to binary) when handling text.',
  analogy_en = 'An international phone book for characters. Because every computer in the world agrees that "65 means A," they can exchange text data seamlessly.',
  pitfall_en = 'ASCII was designed for English, so it cannot represent Japanese, Chinese, or many other writing systems. For those, separate encodings like Shift-JIS or UTF-8 are needed. Today, UTF-8 has become the global standard.'
WHERE term = 'ASCII' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'The raw language of 0s and 1s that a computer directly understands',
  definition_en = 'A set of instructions that a CPU can execute directly. Composed entirely of 0s and 1s, it is extremely difficult for humans to read—but it is the only language a computer truly understands.',
  mechanism_en = 'Programs written in languages like Python or JavaScript are ultimately converted into machine language before the CPU executes them. This translation is performed by tools called compilers or interpreters.',
  analogy_en = 'When communicating with someone from another country, you ultimately need to speak their native tongue to be understood. Machine language is the computer''s "native tongue"—every programming language is eventually translated into it.',
  pitfall_en = 'A common misconception is that you need to learn machine language to program. In practice, modern high-level languages like Python and JavaScript are automatically translated into machine language for you.'
WHERE term = 'Machine language' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'Instructions written in a programming language',
  definition_en = 'Instructions for a computer written using a programming language. Designed to be readable and writable by humans, code is later converted into machine language for execution. Also called "source code."',
  mechanism_en = 'Code is saved as a text file and converted into machine language by a compiler or interpreter. For example, writing print("Hello") causes the text "Hello" to appear on screen.',
  analogy_en = 'Like a cooking recipe. Just as a recipe lists steps—"chop the onion, saut??, add salt"—code lays out instructions in order, and the computer follows them precisely.',
  pitfall_en = 'While "code" can also mean "a secret cipher," in programming it simply means "instructions." The act of writing code is called "coding."'
WHERE term = 'Code' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'A collection of instructions that tells a computer what to do',
  definition_en = 'A set of code (instructions) organized to perform a specific task. It tells a computer what to do and in what order.',
  mechanism_en = 'A program is stored as a file. When you run it, it gets loaded into memory and the CPU processes each instruction one by one, in sequence.',
  analogy_en = 'Just like a schedule for a school sports day: "1. Opening ceremony, 2. Sprint race, 3. Ball toss..." A program is essentially a to-do list for the computer, laying out tasks and their order.',
  pitfall_en = 'People often confuse "program" and "app." An app is actually a type of program—one designed for a specific user-facing purpose.'
WHERE term = 'Program' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'A program built for a specific purpose',
  definition_en = 'Short for "application." Software designed for users to accomplish specific tasks. Calculators, notepads, games—there is an app for virtually every purpose.',
  mechanism_en = 'Apps run on top of an operating system. They receive user input, process it, and display results on screen. Types include mobile apps, web apps, and desktop apps.',
  analogy_en = 'Think of individual tools in a toolbox. A hammer (calculator app), a saw (notes app), a tape measure (maps app)—each tool excels at a particular job.',
  pitfall_en = 'People often treat "app" and "software" as synonyms, but an app is just one category of software. Software also includes operating systems, drivers, and other behind-the-scenes programs.'
WHERE term = 'App' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'All the programs that make a computer work',
  definition_en = 'A general term for programs that run on a computer—including apps, operating systems, and drivers. In contrast to physical hardware, software refers to the intangible programs that bring machines to life.',
  mechanism_en = 'Software runs on hardware (the physical machine) and tells it what to do. A computer can only function when both hardware and software work together.',
  analogy_en = 'If the human body is hardware, the mind is software. A body without a mind cannot act, and a mind without a body has no way to act—both are essential.',
  pitfall_en = '"Software" does not just mean apps. Operating systems, firmware, and many other programs that users never interact with directly are also software.'
WHERE term = 'Software' AND chapter_id = 1;

UPDATE terms SET
  one_liner_en = 'A container for storing data',
  definition_en = 'The basic unit for saving and managing data on a computer. Documents, images, music, programs—all data is stored as files.',
  mechanism_en = 'Each file has a name and an extension indicating its type—for example, report.txt or photo.jpg. Files are organized into folders (also called directories).',
  analogy_en = 'Just like a physical file folder that holds paper documents. You sort documents into labeled folders to stay organized—digital files work the same way.',
  pitfall_en = 'Many people assume deleted files can always be recovered. Once you empty the trash, recovery becomes very difficult. Always back up important files.'
WHERE term = 'File' AND chapter_id = 1;
