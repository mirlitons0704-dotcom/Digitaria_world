# Development Guide

## Quick Start

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Run tests
npm test
```

## Available Scripts

| Script                  | Description                    |
| ----------------------- | ------------------------------ |
| `npm run dev`           | Start Vite development server  |
| `npm run build`         | Build for production           |
| `npm run preview`       | Preview production build       |
| `npm run lint`          | Run ESLint                     |
| `npm run typecheck`     | Run TypeScript type checking   |
| `npm test`              | Run tests in watch mode        |
| `npm run test:run`      | Run tests once                 |
| `npm run test:coverage` | Run tests with coverage report |

## Pre-Push Git Hooks

This project uses Husky to enforce code quality before pushing.

### Pre-Commit Hook

Runs `lint-staged` to format staged files with Prettier.

### Pre-Push Hook

The following checks run before each push:

1. **Documentation Audit** (blocking)
   - Verifies all components/hooks are documented in `docs/FRONTEND.md`
   - Detects ghost references (documented but non-existent files)
   - Run manually: `./scripts/docs-audit.sh`

2. **Test Audit** (blocking)
   - Ensures components/hooks have corresponding test files
   - Supports exceptions via `scripts/.test-exceptions`
   - Run manually: `./scripts/test-audit.sh`

3. **TypeScript Check** (blocking)
   - `tsc --noEmit -p tsconfig.app.json`

4. **ESLint** (blocking)
   - `eslint .`

5. **Tests** (blocking)
   - `npm test -- --run`

6. **Security Audit - Production** (blocking)
   - `npm audit --omit=dev --audit-level=high`

7. **Security Audit - Dev** (warning only)
   - `npm audit --audit-level=high`

8. **File Size Audit** (warning only)
   - Warns about files exceeding 400 lines
   - Run manually: `./scripts/file-size-audit.sh`

### Bypassing Hooks (Emergency Only)

```bash
git push --no-verify
```

⚠️ Use sparingly and ensure CI catches any issues.

## Adding New Components

1. Create component in `src/components/`
2. Add test file: `ComponentName.test.tsx`
3. Document in `docs/FRONTEND.md`
4. Or add to `scripts/.test-exceptions` if test is deferred

## Adding New Hooks

1. Create hook in `src/hooks/`
2. Add test file: `useHookName.test.ts`
3. Document in `docs/FRONTEND.md`
4. Or add to `scripts/.test-exceptions` if test is deferred

## Test Exceptions

Files listed in `scripts/.test-exceptions` are exempt from test requirements:

```
# scripts/.test-exceptions
AuthForm.tsx
Layout.tsx
TermCard.tsx
useCharacters.ts
```

## Code Style

- **Formatter**: Prettier (auto-runs on commit)
- **Linter**: ESLint with TypeScript support
- **Naming**: PascalCase for components, camelCase for hooks/functions

### Prettier Config (`.prettierrc`)

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2
}
```

## Project Structure

```
Digitaria_world/
├── .husky/                 # Git hooks
│   ├── pre-commit         # Lint-staged
│   └── pre-push           # All quality checks
├── docs/
│   ├── DEVELOPMENT.md     # This file
│   ├── FRONTEND.md        # Component/hook documentation
│   └── stories/           # Story chapters (1-16)
├── scripts/
│   ├── docs-audit.sh      # Documentation verification
│   ├── test-audit.sh      # Test coverage verification
│   ├── file-size-audit.sh # File size warnings
│   └── .test-exceptions   # Files exempt from tests
├── src/
│   ├── components/        # React components
│   ├── hooks/             # Custom React hooks
│   ├── lib/               # Utilities (api, supabase, types)
│   ├── pages/             # Page components
│   ├── contexts/          # React contexts
│   └── test/              # Test utilities
├── supabase/              # Supabase functions
├── .prettierrc            # Prettier config
├── eslint.config.js       # ESLint config
├── vitest.config.ts       # Vitest config
└── package.json
```

## Troubleshooting

### Pre-push hook fails on docs-audit

```bash
VERBOSE=1 ./scripts/docs-audit.sh
```

This shows which files are undocumented or ghost references.

### Pre-push hook fails on test-audit

Either add tests for the missing files or add them to `scripts/.test-exceptions`.

### TypeScript/ESLint errors

Run locally to see details:

```bash
npm run typecheck
npm run lint
```
