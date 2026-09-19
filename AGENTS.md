# Dade Games - Godot 4 Game Builder

This folder is set up with godogen skills for building Godot 4 games.

## How to make a game

Open Claude Code in this folder and use the `/godogen` skill:

```
/godogen Make a simple 2D platformer game where a knight collects coins
```

The pipeline will:
1. Design the architecture
2. Generate art assets
3. Write all the code
4. Test and screenshot the game

## API Keys needed (set as environment variables)
- `GOOGLE_API_KEY` — Required for art generation and visual QA
- `TRIPO3D_API_KEY` — Optional, for 3D model generation (3D games only)

## Capture on macOS

Screenshot capture uses Metal (Apple Silicon / Intel GPU). No X11 needed.
The capture script uses: `--display-driver macos --rendering-driver metal`

See `.claude/skills/godot-task/capture.md` for details.
