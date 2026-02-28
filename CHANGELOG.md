# Changelog

All notable changes to the Digitalia project are documented in this file.

## [Unreleased]

### Added

#### Test Suite (2026-02-06)

- Vitest test framework setup with jsdom environment
- Test utilities (`src/test/test-utils.tsx`)
  - Mock data factories: `createMockChapter`, `createMockTerm`, `createMockCharacter`
  - Custom render function with BrowserRouter provider
- Component tests
  - `ChapterCard.test.tsx` - 11 tests for rendering, interactions, progress states
  - `FlashCard.test.tsx` - 19 tests for flip functionality, difficulty display
- Hook tests
  - `useChapters.test.ts` - 8 tests for chapter fetching hooks
  - `useTerms.test.ts` - 14 tests for term fetching/searching hooks
- Total: 52 tests passing

#### Pre-Push Git Hooks (2026-02-06)

- Husky setup for Git hooks
- Pre-commit hook: lint-staged with Prettier
- Pre-push hook with quality gates:
  - Documentation audit script (`scripts/docs-audit.sh`)
  - Test coverage audit script (`scripts/test-audit.sh`)
  - File size audit script (`scripts/file-size-audit.sh`)
  - TypeScript type checking
  - ESLint linting
  - Test execution
  - npm security audit

#### Configuration Files (2026-02-06)

- `.prettierrc` - Code formatting rules
- `.prettierignore` - Prettier exclusions
- Updated `eslint.config.js` - Added unused variable rules, test file exceptions
- Updated `vitest.config.ts` - Coverage configuration
- `scripts/.test-exceptions` - Test requirement exemptions

#### Documentation (2026-02-06)

- `docs/FRONTEND.md` - Component and hook documentation
- `docs/DEVELOPMENT.md` - Development workflow guide
- `CHANGELOG.md` - This file

#### Story Content Organization (2026-02-06)

- Split integrated story files into individual chapters
- Created `docs/stories/` directory with:
  - `prologue.md` - World setting introduction
  - `chapter01.md` through `chapter16.md` - Individual chapters
  - `ending.md` - Story conclusion
  - `appendix.md` - Character introductions and term index

### Changed

- Updated `package.json` with lint-staged configuration
- Updated `.gitignore` to exclude coverage and `.oversized-files`

### Fixed

- Unused variable warnings in `AuthForm.tsx` and `seed-terms/index.ts`
- Test assertion issues in `FlashCard.test.tsx` and `useTerms.test.ts`

## Project Setup (2026-02-06)

### Initial Configuration

- Cloned repository from GitHub
- Configured environment variables (`.env`)
  - `VITE_SUPABASE_URL`
  - `VITE_SUPABASE_ANON_KEY`
- Installed project dependencies

---

## Version History

### Tech Stack

- React 18 with TypeScript
- Vite 5.x
- Tailwind CSS 3.x
- Supabase (PostgreSQL + Auth)
- React Router v7
- Vitest 4.x for testing
