# Frontend Documentation

## Overview

Digitaria is a programming term learning web application built with React, TypeScript, and Supabase.

## Tech Stack

- **Framework**: React 18 with TypeScript
- **Build Tool**: Vite
- **Styling**: Tailwind CSS
- **Backend**: Supabase (PostgreSQL + Auth)
- **Routing**: React Router v7

## Components

### AuthForm.tsx

Authentication form component for user login and registration.

- Location: `src/components/AuthForm.tsx`
- Features: Email/password authentication, form validation

### ChapterCard.tsx

Displays chapter information in a card format.

- Location: `src/components/ChapterCard.tsx`
- Props: chapter data, progress, lock state
- Features: Progress indicator, special styling for story chapters

### FlashCard.tsx

Interactive flip card for learning programming terms.

- Location: `src/components/FlashCard.tsx`
- Props: term data, onFlip callback, difficulty
- Features: Front/back display, difficulty stars, analogy, pitfall, related terms

### Layout.tsx

Main layout wrapper component with navigation.

- Location: `src/components/Layout.tsx`
- Features: Header, navigation, responsive design

### TermCard.tsx

Displays term information in a compact card format.

- Location: `src/components/TermCard.tsx`
- Features: Term name, description, chapter reference

## Hooks

### useChapters.ts

Hooks for fetching and managing chapter data.

- Location: `src/hooks/useChapters.ts`
- Exports:
  - `useChapters()`: Fetches all chapters
  - `useChapter(id)`: Fetches single chapter by ID
  - `useChapterWithGuide(id)`: Fetches chapter with study guide

### useCharacters.ts

Hooks for fetching character data.

- Location: `src/hooks/useCharacters.ts`
- Exports:
  - `useCharacters()`: Fetches all characters
  - `useCharacter(id)`: Fetches single character by ID

### useTerms.ts

Hooks for fetching and searching programming terms.

- Location: `src/hooks/useTerms.ts`
- Exports:
  - `useTermsByChapter(chapterId)`: Fetches terms for a specific chapter
  - `useTerm(id)`: Fetches single term by ID
  - `useSearchTerms(query)`: Searches terms with 300ms debounce
  - `useQuizTerms(chapterId, count)`: Fetches random terms for quiz

## Directory Structure

```
src/
├── components/
│   ├── AuthForm.tsx
│   ├── ChapterCard.tsx
│   ├── ChapterCard.test.tsx
│   ├── FlashCard.tsx
│   ├── FlashCard.test.tsx
│   ├── Layout.tsx
│   └── TermCard.tsx
├── hooks/
│   ├── useChapters.ts
│   ├── useChapters.test.ts
│   ├── useCharacters.ts
│   ├── useTerms.ts
│   └── useTerms.test.ts
├── lib/
│   ├── api.ts
│   ├── database.types.ts
│   └── supabase.ts
├── pages/
│   └── (page components)
└── test/
    ├── setup.ts
    └── test-utils.tsx
```

## Testing

- Test framework: Vitest
- Testing library: @testing-library/react
- Run tests: `npm test` or `npm run test:run`
- Coverage: `npm run test:coverage`
