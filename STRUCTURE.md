# Coin Caper

## Dimension: 2D

## Input Actions

| Action | Keys |
|--------|------|
| move_left | A, Left |
| move_right | D, Right |
| jump | Space, Up |
| restart | Enter, R |

## Scenes

### Main
- **File:** res://scenes/main.tscn
- **Root type:** Node2D
- **Children:** Platforms (Node2D), Coins (Node2D), Player, CanvasLayer (HUD)
- **Script:** res://scripts/game_manager.gd

### Player
- **File:** res://scenes/player.tscn
- **Root type:** CharacterBody2D
- **Children:** CollisionShape2D, Sprite2D (drawn in script)
- **Script:** res://scripts/player.gd

### Coin
- **File:** res://scenes/coin.tscn
- **Root type:** Area2D
- **Children:** CollisionShape2D, Sprite2D (drawn in script)
- **Script:** res://scripts/coin.gd

## Scripts

### GameManager
- **File:** res://scripts/game_manager.gd
- **Extends:** Node2D
- **Attaches to:** Main
- **Signals emitted:** (none)
- **Signals received:** Coin.collected -> _on_coin_collected

### PlayerController
- **File:** res://scripts/player.gd
- **Extends:** CharacterBody2D
- **Attaches to:** Player:Player
- **Signals emitted:** (none)
- **Signals received:** (none)

### Coin
- **File:** res://scripts/coin.gd
- **Extends:** Area2D
- **Attaches to:** Coin:Coin
- **Signals emitted:** collected
- **Signals received:** body_entered -> _on_body_entered

## Signal Map

- Coin:body_entered -> CoinScript._on_body_entered (emits `collected`)
- Main:Coins/{each coin}.collected -> GameManager._on_coin_collected

## Asset Hints

- Player: orange round cartoon character, ~64x64 px, drawn procedurally
- Coin: gold circle with star, ~32x32 px, drawn procedurally
- Platform: green top with brown body rectangle, drawn procedurally
- Background: solid blue sky gradient, drawn procedurally
- HUD: score label top-left, white bold text
