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

### AdminLayout.tsx

Layout wrapper for the admin panel with sidebar navigation.

- Location: `src/components/AdminLayout.tsx`
- Features: Sidebar with Dashboard/Users/Analytics navigation, back-to-app link, dark theme

### AdminLayout.tsx

Admin panel layout with sidebar navigation.

- Location: `src/components/AdminLayout.tsx`
- Features: Dashboard/Users/Analytics navigation, dark theme sidebar, back-to-app link

### AuthForm.tsx

Authentication form component for user login and registration.

- Location: `src/components/AuthForm.tsx`
- Features: Email/password authentication, form validation, loading state

### ChapterCard.tsx

Displays chapter information in a card format.

- Location: `src/components/ChapterCard.tsx`
- Props: chapter data, progress, lock state, isSpecial
- Features: Progress indicator, special styling for epilogue, category icons

### InlineTermCard.tsx

Expanded term card shown inline within the story teleprompter.

- Location: `src/components/InlineTermCard.tsx`
- Props: term data, isCollected, saving state, onClose, onGotIt
- Features: Definition, mechanism, analogy, pitfall, related terms, butterfly collection button

### Layout.tsx

Main layout wrapper component with navigation.

- Location: `src/components/Layout.tsx`
- Features: Header, desktop + mobile navigation, user profile display

### StoryTeleprompter.tsx

Auto-scrolling story reader with TTS (text-to-speech) support.

- Location: `src/components/StoryTeleprompter.tsx`
- Props: scenes, chapterTitle, terms
- Features: Auto-scroll with speed control, keyboard navigation, inline term cards, Gemini TTS playback, progress tracking, butterfly collection

### TermCard.tsx

Expandable term card for term list pages.

- Location: `src/components/TermCard.tsx`
- Props: term data, isExpanded, onToggle
- Features: Difficulty stars, definition, mechanism, analogy, pitfall, related terms

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

### useStoryScenes.ts

Hook for fetching story scenes by chapter.

- Location: `src/hooks/useStoryScenes.ts`
- Exports:
  - `useStoryScenes(chapterId)`: Fetches all scenes for a chapter, ordered by scene_number

### useTts.ts

Hook for text-to-speech playback of story scenes via Gemini TTS.

- Location: `src/hooks/useTts.ts`
- Exports:
  - `useTts(scenes)`: Returns status, currentSceneIndex, play/pause/stop controls
- Features: Sequential scene playback, AbortController cleanup, object URL memory management

## Lib (Utilities)

### api.ts

API functions for all Supabase data access.

- Location: `src/lib/api.ts`
- Key functions: getChapters, getTermsByChapter, searchTerms, saveTermProgress, getUserCollectedTerms

### constants.ts

Shared constants for the application.

- Location: `src/lib/constants.ts`
- Exports:
  - `STORAGE_URL`: Base URL for Supabase Storage
  - `ASSETS`: Object containing all asset URLs (images, videos)

### geminiTts.ts

Client-side TTS helper that calls the Supabase Edge Function.

- Location: `src/lib/geminiTts.ts`
- Exports:
  - `generateSpeech(text, options)`: Returns a WAV Blob from PCM audio via Edge Function

## Directory Structure

```
src/
├── components/
│   ├── AdminLayout.tsx
│   ├── AuthForm.tsx
│   ├── ChapterCard.tsx
│   ├── InlineTermCard.tsx
│   ├── Layout.tsx
│   ├── StoryTeleprompter.tsx
│   └── TermCard.tsx
├── hooks/
│   ├── useChapters.ts
│   ├── useCharacters.ts
│   ├── useStoryScenes.ts
│   ├── useTerms.ts
│   ├── useTts.ts
│   └── index.ts
├── lib/
│   ├── api.ts
│   ├── constants.ts
│   ├── database.types.ts
│   ├── geminiTts.ts
│   └── supabase.ts
├── pages/
│   ├── LandingPage.tsx
│   ├── HomePage.tsx
│   ├── ChapterPage.tsx
│   ├── TermListPage.tsx
│   ├── MyFolderPage.tsx
│   ├── SearchPage.tsx
│   └── index.ts
├── contexts/
│   └── AuthContext.tsx
└── test/
    ├── setup.ts
    └── test-utils.tsx
```

## Testing

- Test framework: Vitest
- Testing library: @testing-library/react
- Run tests: `npm test` or `npm run test:run`
- Coverage: `npm run test:coverage`
