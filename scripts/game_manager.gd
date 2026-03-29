extends Node2D
## res://scripts/game_manager.gd — Manages platforms, coins, score, and win condition

var score: int = 0
var total_coins: int = 0
var coins_collected: int = 0

@onready var _platforms_container: Node2D = $Platforms
@onready var _coins_container: Node2D = $Coins
@onready var _player: CharacterBody2D = $Player
@onready var _score_label: Label = $HUD/Control/ScoreLabel
@onready var _win_label: Label = $HUD/Control/WinLabel

# Platform data: [x, y, width] — y is center, x is center
const PLATFORM_DATA: Array = [
	[640.0, 688.0, 1280.0, 30.0],   # ground
	[200.0, 530.0, 220.0, 30.0],    # lower-left
	[650.0, 450.0, 200.0, 30.0],    # center
	[1050.0, 370.0, 200.0, 30.0],   # upper-right
	[300.0, 300.0, 180.0, 30.0],    # upper-left
]

# Coin positions: [x, y] (placed ~30px above platform top)
const COIN_DATA: Array = [
	[150.0, 494.0],
	[220.0, 494.0],
	[290.0, 494.0],
	[620.0, 414.0],
	[680.0, 414.0],
	[1030.0, 334.0],
	[1090.0, 334.0],
	[280.0, 264.0],
	[340.0, 264.0],
]

func _ready() -> void:
	_spawn_platforms()
	_spawn_coins()
	_update_score_label()

	# Style score label
	_score_label.add_theme_font_size_override("font_size", 36)
	_score_label.add_theme_color_override("font_color", Color.WHITE)
	_score_label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0))
	_score_label.add_theme_constant_override("outline_size", 4)

	# Style win label
	_win_label.add_theme_font_size_override("font_size", 56)
	_win_label.add_theme_color_override("font_color", Color(1.0, 1.0, 0.0))
	_win_label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0))
	_win_label.add_theme_constant_override("outline_size", 6)
	_win_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_win_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

func _spawn_platforms() -> void:
	var plat_script: GDScript = load("res://scripts/platform.gd")
	for data in PLATFORM_DATA:
		var plat = StaticBody2D.new()
		plat.set_script(plat_script)
		plat.platform_width = data[2]
		plat.platform_height = data[3]
		plat.position = Vector2(data[0], data[1])
		plat.collision_layer = 4   # layer 3 = platforms bitmask 4
		plat.collision_mask = 0
		_platforms_container.add_child(plat)

func _spawn_coins() -> void:
	var coin_scene: PackedScene = load("res://scenes/coin.tscn")
	total_coins = COIN_DATA.size()
	for data in COIN_DATA:
		var coin = coin_scene.instantiate()
		coin.position = Vector2(data[0], data[1])
		_coins_container.add_child(coin)
		coin.collected.connect(_on_coin_collected)

func _on_coin_collected() -> void:
	coins_collected += 1
	score += 1
	_update_score_label()
	if coins_collected >= total_coins:
		_show_win()

func _update_score_label() -> void:
	_score_label.text = "SCORE: %d" % score

func _show_win() -> void:
	_win_label.text = "YOU WIN!\nPress R or Enter to restart"
	_win_label.visible = true

func _process(_delta: float) -> void:
	if _win_label.visible:
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()

