# Flappy Bird Clone — Solo Dev Workflow

Small solo project for testing the Claude Code workflow. Intentionally trimmed
to the bare minimum. No sprints, no epics, no ADRs, no traceability matrix.

## Stack

- **Engine**: Godot 4 (see `docs/engine-reference/godot/VERSION.md` for pinned version)
- **Language**: GDScript
- **Version Control**: Git

## Project Structure

@.claude/docs/directory-structure.md

## Engine Version Reference

@docs/engine-reference/godot/VERSION.md

## Coding Standards

@.claude/docs/coding-standards.md

## Solo Workflow

The whole loop:

1. `/brainstorm` — what's the game (skip if you already know)
2. `/setup-engine` — pin Godot version (once)
3. `/design-system` — one short GDD for the core mechanic
4. Code it (use `gameplay-programmer` or `godot-gdscript-specialist` agents)
5. `/code-review` before merging
6. `/smoke-check` before declaring done
7. Ship

Skip everything else unless you actually need it.

## Available Agents

- `godot-specialist` — Godot 4 patterns and APIs
- `godot-gdscript-specialist` — GDScript code quality
- `game-designer` — design questions and the one GDD
- `gameplay-programmer` — implementation
- `qa-tester` — write a test or a bug report

## Available Skills

`/brainstorm`, `/setup-engine`, `/design-system`, `/prototype`, `/code-review`,
`/test-setup`, `/smoke-check`, `/bug-report`, `/start`, `/help`

## Solo-Dev Rules

- **No ADRs.** If you make a technical choice, just make it. Write a comment if it matters.
- **No epic/story/sprint ceremony.** Use a TODO list. Done.
- **One GDD max.** Flappy Bird has one mechanic. Don't over-document.
- **Tests where they help.** Logic (score, collision math) → unit test. Visual → click around.
- **Commit when something works.** Conventional Commits style (`feat:`, `fix:`, `chore:`).
- **Ask before destructive actions.** Otherwise just go.
