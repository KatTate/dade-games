# Game Plan: Coin Caper

## Game Description

Make a simple 2D coin collector game. A character walks left/right, jumps, and collects coins for points. Plain colorful sprites. Keep it simple.

## 1. Core Game
- **Depends on:** (none)
- **Status:** pending
- **Targets:** project.godot, scenes/main.tscn, scenes/player.tscn, scenes/coin.tscn, scripts/player.gd, scripts/coin.gd, scripts/game_manager.gd
- **Goal:** Complete playable game — player can walk, jump, collect coins that count toward a score, with a score HUD. Simple single-screen level with platforms and scattered coins.
- **Requirements:**
  - Player is an orange round cartoon character (~64x64 px), walks left/right with arrow keys or A/D, jumps with Space or Up
  - Gravity applies; player lands on platforms
  - Level has a ground platform and 3–5 floating platforms arranged so the player can jump between them
  - Coins (gold star-coin, ~32x32 px) are placed on platforms; collecting one plays a sound effect and adds +1 to score
  - Score displayed in top-left HUD (white bold text with dark outline, large font)
  - When all coins collected, display "You Win!" and a restart prompt
  - Colorful sprites drawn in GDScript using draw calls (no external image files needed): orange circle for player, yellow circle with star outline for coin, green rectangles for platforms
- **Assets needed:** Colorful sprites generated in GDScript — player as orange circle with eyes, coins as gold circles, platforms as green/brown rectangles
- **Verify:** Screenshot shows player standing on a platform, several coins visible on other platforms, score "0" (or more) displayed in top-left. Player can jump and coins disappear on contact.

## 2. Presentation Video
- **Depends on:** 1
- **Status:** pending
- **Targets:** test/presentation.gd, screenshots/presentation/gameplay.mp4
- **Goal:** Create a ~30-second cinematic video showcasing the completed game.
- **Requirements:**
  - Write test/presentation.gd — a SceneTree script (extends SceneTree)
  - Showcase representative gameplay via simulated input or scripted animations
  - ~900 frames at 30 FPS (30 seconds)
  - Use Video Capture from godot-capture (AVI via --write-movie, convert to MP4 with ffmpeg)
  - Output: screenshots/presentation/gameplay.mp4
  - 2D games: camera pans and smooth scrolling, zoom transitions between overview and close-up, trigger representative gameplay sequences, tight viewport framing
- **Verify:** A smooth MP4 video showing polished gameplay with no visual glitches.
