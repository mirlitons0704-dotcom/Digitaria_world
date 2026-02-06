# Digitaria World

A programming term learning web application where users explore programming concepts through an immersive story.

## Tech Stack

- **Frontend**: React 18 + TypeScript + Vite
- **Styling**: Tailwind CSS
- **Backend**: Supabase (PostgreSQL + Auth)
- **Testing**: Vitest + React Testing Library

## Quick Start

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Run tests
npm run test:run
```

## Development

This project uses Git hooks to ensure code quality:

- **Pre-commit**: Prettier formatting via lint-staged
- **Pre-push**: TypeScript, ESLint, tests, documentation audit

See [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md) for detailed development workflow.

## Documentation

- [Development Guide](docs/DEVELOPMENT.md) - Setup and workflow
- [Frontend Documentation](docs/FRONTEND.md) - Components and hooks
- [Changelog](CHANGELOG.md) - Version history

## Project Structure

```
src/
├── components/    # React components
├── hooks/         # Custom React hooks
├── lib/           # API and utilities
├── pages/         # Page components
├── contexts/      # React contexts
└── test/          # Test utilities
```

## Available Scripts

| Script                  | Description             |
| ----------------------- | ----------------------- |
| `npm run dev`           | Start dev server        |
| `npm run build`         | Build for production    |
| `npm run lint`          | Run ESLint              |
| `npm run typecheck`     | TypeScript check        |
| `npm run test:run`      | Run tests               |
| `npm run test:coverage` | Run tests with coverage |
