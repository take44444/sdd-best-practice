# [Project Name] frontend

[Project Name] frontend is a web application frontend of [Project Name]. [Project Name] is a [brief description of the project].

The backend of [Project Name] is developed in another repository. The backend provides [main functionality of the backend] for the application. The frontend communicates with the backend to [main purpose of the frontend-backend interaction].

## Core Principles

### 1. Test-Driven Development (TDD)

- Red-Green-Refactor cycle **MUST** be followed for all development.
- All new features and bug fixes **MUST** have corresponding tests that cover the functionality being implemented or fixed.
- Tests **MUST** be written before the implementation based on the requirements and expected behavior of the feature or bug fix.

### 2. Quality Gates

- All code **MUST** pass linting checks and adhere to the project's coding standards.
- All code **MUST** have a code coverage of at least 80% for new features and bug fixes.
- All tests **MUST** pass.

## Technical Stack

- TypeScript
- Next.js for the frontend framework
- Tailwind CSS v4 for styling
- Auth.js for authentication
- Jest for unit testing
- Playwright for end-to-end testing
- ESLint and Prettier for linting and code formatting

## Project and Code Guidelines

- Must follow Google TypeScript Style Guide
- Types must be explicitly defined for all classes, interfaces, constants, variables, function parameters, and return types.
- Type "any" **MUST NOT** be used. All types must be explicitly defined to ensure type safety and maintainability.
- Docstrings **MUST** be provided for all public classes, interfaces, and functions.
- Must use Next.js App Router for routing.

## Style

### Color Palette

```css
/* Light Theme */
:root {
  --background: [Base];
  --foreground: [BaseForeground];
  --primary: [Primary];
  --primary-foreground: [Base];
  --secondary: [Secondary];
  --secondary-foreground: [Primary];
  --muted: [Secondary];
  --muted-foreground: [MutedForeground];
  --destructive: [Destructive];
  --border: [DarkPrimary];
  --input: [DarkPrimary];
  --ring: [Ring];
}
```

```css
/* Dark Theme */
.dark {
  --background: [BaseForeground];
  --foreground: [Base];
  --primary: [DarkPrimary];
  --primary-foreground: [Primary];
  --secondary: [DarkSecondary];
  --secondary-foreground: [Base];
  --muted: [DarkSecondary];
  --muted-foreground: [Ring];
  --destructive: [DarkDestructive];
  --border: [DarkBorder];
  --input: [DarkBorder];
  --ring: [MutedForeground];
}
```

### Fonts

- font-sans: Inter for headings and body text
- font-mono: Geist Mono for inline code snippets and code blocks

## Environment Variables

The environment variables used in the application are defined in the `.env` fiele located in the root directory of the project. You can use the values for development and testing purposes.
