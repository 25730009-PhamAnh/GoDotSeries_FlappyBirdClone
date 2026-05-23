# Flappy Bird Clone — Design Note

## What it is

A 2D one-button game where you tap to keep a bird airborne through gaps in scrolling pipes.

## Core mechanic

- Bird is always falling (constant gravity).
- One input: **Space** / **Click** / **Touch** → applies an upward velocity (a "flap").
- Pipes spawn off-screen right, scroll left at constant speed, with a vertical gap of random Y position.
- Touch a pipe or the ground → instant game over.
- Each pipe pair you pass through → +1 score.
- Game-over screen shows score + best score (persisted). Press a button to restart.

## Tuning knobs

All in `res://data/tuning.tres` (Godot Resource), or `@export` on the relevant node.

| Knob | Starting value | What it controls |
|---|---|---|
| `gravity` | **1200 px/s²** | How fast the bird falls |
| `flap_velocity` | **-380 px/s** (negative = up) | Strength of each flap |
| `max_fall_speed` | **600 px/s** | Caps downward velocity so bird doesn't tunnel |
| `pipe_scroll_speed` | **150 px/s** | How fast pipes (and ground) move left |
| `pipe_gap` | **140 px** | Vertical opening between top and bottom pipe |
| `pipe_spawn_interval` | **1.4 s** | Time between pipe pair spawns |
| `pipe_gap_y_min` | **120 px** (from top) | Top bound for gap center |
| `pipe_gap_y_max` | **(viewport height - 200)** | Bottom bound for gap center |
| `viewport_size` | **288 × 512** (classic Flappy ratio) | Logical resolution; scaled up for display |
| `bird_rotation_max` | **±30°** | Visual tilt up on flap, down while falling |

> **Tuning rule of thumb:** if the game feels too hard, lower `gravity` first or widen `pipe_gap`. Don't touch `flap_velocity` unless flaps feel weak — that's the input feedback knob.

## What "done" looks like

1. ✅ I can run the game, tap to flap, and survive at least 5 pipes if I'm trying.
2. ✅ Hitting a pipe or the ground ends the run and shows my score + best score.
3. ✅ Restarting puts the bird back at the start, score at 0, pipes cleared.

## Out of scope (for v1)

- Menu screen (game can start on first tap)
- Animations beyond bird tilt + flap sprite swap
- Multiple bird skins, day/night cycle, medals — all "if I'm bored" stretch
- Online leaderboard
- Sound polish beyond one flap SFX, one hit SFX, one point SFX
