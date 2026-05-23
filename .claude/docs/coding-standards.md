# Coding Standards (solo)

## Code

- Static typing in GDScript (`var x: int = 0`, `func foo(n: int) -> void:`)
- Tunable values (gravity, jump force, pipe speed, gap size) live in an exported
  config or `@export` vars — never hardcoded inside game logic
- Doc comments on anything non-trivial. Skip them on obvious code.
- Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`

## Design Docs

- Markdown
- One file is plenty for a Flappy Bird clone. Put it in `design/gdd/`.
- Suggested sections (use what you need, ignore the rest):
  - Core mechanic (one paragraph)
  - Numbers / tuning knobs (gravity, jump force, gap, scroll speed, score rule)
  - What "done" looks like (1-3 bullets)

## Tests

- Logic (score counter, collision math, RNG seeding): write a unit test.
- Visual / feel (animation, sound timing): play the game.
- File naming: `<system>_<feature>_test.gd` in `tests/unit/`
- No flaky tests. Deterministic only — pass a seed if you need RNG.
- Godot test runner: `godot --headless --script tests/gdunit4_runner.gd`

## What NOT to do

- Don't write ADRs for a Flappy Bird clone.
- Don't write sprint plans or story files.
- Don't gate yourself on a smoke check — run it when convenient.
- Don't add error handling for impossible cases.
