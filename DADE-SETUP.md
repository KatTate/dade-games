# Dade's Godogen Setup Guide

Hey Dade! This guide shows you how to use **godogen** — an AI tool that builds Godot games for you from a description.

---

## What You Need First

Make sure you have these installed on the Mac Mini:
- **Godot 4** (already installed at `/opt/homebrew/bin/godot`)
- **Claude** (already installed)

---

## How to Make a New Game

**Step 1:** Open Terminal on the Mac Mini.

**Step 2:** Go to your games folder:
```
cd ~/dade-games
```

**Step 3:** Start Claude:
```
claude
```

**Step 4:** Type the godogen command and describe your game. For example:
```
/godogen Make a 2D platformer where a ninja jumps between rooftops and collects shurikens
```

Just replace the description with whatever game you want to make. Be specific about:
- What the player looks like
- What the player does (jump, shoot, run, etc.)
- What they collect or avoid
- The art style (colorful, pixel art, dark, etc.)

**Step 5:** Wait. The AI will:
1. Plan the game architecture
2. Generate art assets (sprites, backgrounds)
3. Write all the GDScript code
4. Take a screenshot to verify it looks right

This usually takes **3-10 minutes**.

---

## Where Your Game Ends Up

All generated files go in `~/dade-games/`:
- `project.godot` — the Godot project file (open this in Godot)
- `scenes/` — all the scene files (.tscn)
- `scripts/` — all the game logic (.gd)
- `assets/img/` — all the sprites and images
- `screenshots/` — screenshots taken during testing

---

## How to Open and Play the Game

After godogen finishes:

1. Open **Godot**
2. Click **Import**
3. Navigate to `~/dade-games/`
4. Select `project.godot`
5. Click **Import & Edit**
6. Press **F5** (or the Play button) to run the game

---

## The Coin Caper (Example Game)

There's already a test game in `~/dade-games/` called **Coin Caper**:
- Arrow keys or A/D to walk
- Space or Up to jump
- Collect all the coins on the platforms to win
- Score shows in the top-left corner

Open it in Godot and try it out!

---

## Tips for Better Games

- **Be specific:** "a fat orange cat that bounces on trampolines and eats fish" works better than "a platformer"
- **Ask for a style:** "pixel art style" or "bright cartoon colors" affects how the sprites look
- **Keep it simple first:** simple games generate faster and work better out of the box
- **Iterate:** if you don't like something, just run godogen again with a tweaked description

---

## If Something Goes Wrong

If the game doesn't open or looks broken:
- Check `~/dade-games/visual-qa/` — godogen saves a QA report there explaining any issues it found
- Ask Tate — he can have the AI fix specific issues
