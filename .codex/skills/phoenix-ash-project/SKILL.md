---
name: phoenix-ash-project
description: Use when working in Phoenix LiveView plus Ash projects that should optimize for navigability, progressive disclosure, strong naming, small API surfaces, and clear responsibility boundaries. Follow the local project instructions first, then use this skill for architectural decisions, naming consistency, Ash actions and code interfaces, AshPhoenix forms, multitenant behavior, Igniter-assisted refactors, modal and focus issues, and maintainable LiveView structure.
---

# Phoenix Ash Project

## Start Here

1. Read local project instructions first:
   1.1. `AGENTS.md` if present
   1.2. `notes/OVERVIEW.md` or similar project notes if present
2. Prefer local code inspection before speculation.
3. Respect project-local conventions over global defaults when they conflict.

## Core Principles

1. Optimize for long-term clarity and ease of re-entry.
2. Make the codebase navigable from top-level intent to implementation detail.
3. Prefer progressive disclosure:
   3.1. top-level modules explain the big picture
   3.2. extracted modules hold the detail work
4. Favor small API surfaces and clear responsibility boundaries.
5. Extract early when readability improves, but do not fragment the filesystem without a meaningful boundary.
6. Use orchestration modules as maps and smaller doer modules for focused detail.
7. Prefer strong naming, path-to-module symmetry, and API consistency across related module families.

## Phoenix And LiveView

1. Respect the project's layout, component, and HTML helper conventions.
2. Never add inline `<script>` tags in HEEx.
3. For state-driven client behavior, use hooks when `phx-mounted` is insufficient.
4. Use stable DOM IDs for interactive elements.
5. Prefer project patterns over generic Phoenix examples.
6. LiveViews should mainly orchestrate and render.
7. Extract form and interaction logic once it stops being trivial.
8. In HEEx, prefer grouped `class={[...]}` chunks for scanability rather than one long class string.
9. If a project already uses DaisyUI or a theme system, start with the existing component classes and add utility detail only when needed.

## Ash

1. Check whether the call site uses:
   1.1. a resource action directly
   1.2. a domain code interface
   1.3. `AshPhoenix.Form`
2. Verify exact argument shape before diagnosing validation failures.
3. For tenant-aware resources, confirm the write path receives tenant and actor through the expected API.
4. Prefer `scope: scope` when that is the established pattern in the project.
5. Do not assume a helper persists data unless it clearly writes through an Ash action.

## How To Route Yourself

1. Read `references/style.md` for architecture, naming, splitting rules, symmetry, readability conventions, and general examples.
2. Read `references/ash.md` for code interfaces, forms, actor and tenant flow, multitenancy checks, and Ash-specific examples.
3. Read `references/liveview.md` for lifecycle, hooks, rendering boundaries, extraction rules, and LiveView-specific examples.
4. Read `references/igniter.md` when installing deps, upgrading deps, renaming functions, or planning refactors that Igniter can partially automate.
5. Distinguish intentional structure from rough or transitional code before inferring conventions.
