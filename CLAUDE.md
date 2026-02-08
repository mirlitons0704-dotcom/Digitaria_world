# CLAUDE.md — Digitaria Project Rules

## Project Overview

Digitaria is a web app for learning 520 programming terms through a story-driven experience with 17 chapters. Built with Vite + React + TypeScript + Tailwind CSS + Supabase.

## Tech Stack

- **Frontend**: React 18, TypeScript, Tailwind CSS, Vite
- **Backend**: Supabase (PostgreSQL + Auth + Storage + RLS)
- **Testing**: Vitest + React Testing Library
- **Linting**: ESLint + Prettier + lint-staged + Husky

## Key Directories

- `src/components/` — Reusable UI components
- `src/pages/` — Route-level page components
- `src/hooks/` — Custom React hooks (data fetching with retry support)
- `src/lib/` — API functions, Supabase client, types, constants
- `src/contexts/` — Auth context provider
- `src/test/` — Test setup and utilities
- `supabase/migrations/` — SQL migration files

## Architecture Patterns

- All data fetching goes through `src/lib/api.ts`
- Hooks wrap API calls with loading/error/retry states
- Database types are manually defined in `src/lib/database.types.ts`
- Supabase client is typed with `Database` generic
- RLS policies protect all tables; only anon key is exposed to client

## Commands

- `npm run dev` — Start development server
- `npm run build` — Production build
- `npm run typecheck` — TypeScript type checking
- `npm run lint` — ESLint
- `npm run format` — Prettier formatting
- `npx vitest run` — Run tests
- `npx supabase db push` — Push migrations to Supabase

## Testing Guidelines

- Tests live alongside source files (`*.test.ts` / `*.test.tsx`)
- Use `createMockChapter()`, `createMockTerm()` etc. from `src/test/test-utils.tsx`
- Mock API module with `vi.mock('../lib/api')`
- Use `renderHook` + `waitFor` for hook tests

## Environment Variables

- `VITE_SUPABASE_URL` — Supabase project URL
- `VITE_SUPABASE_ANON_KEY` — Supabase anonymous key (safe for client)

## Important Notes

- Never expose `service_role_key` in frontend code
- All user-facing search input is sanitized via `sanitizeFilterValue()` before passing to PostgREST
- The `saveMultipleTermProgress()` function uses batch upsert for efficiency
- Hooks expose a `retry` function for error recovery
- Pre-push hooks run: typecheck → eslint → vitest → npm audit
