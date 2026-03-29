extends SceneTree
## Scene builder — run: timeout 60 godot --headless --script scenes/build_main.gd

func _initialize() -> void:
	print("Building: main.tscn")

	var root = Node2D.new()
	root.name = "Main"
	root.set_script(load("res://scripts/game_manager.gd"))

	# Solid sky-blue background in game space (matches sprite backgrounds)
	var bg_rect = ColorRect.new()
	bg_rect.name = "SkyBg"
	bg_rect.color = Color.html("87CEEB")  # #87CEEB sky blue
	bg_rect.size = Vector2(1280.0, 720.0)
	bg_rect.position = Vector2.ZERO
	bg_rect.z_index = -10
	root.add_child(bg_rect)

	# Platforms container
	var platforms = Node2D.new()
	platforms.name = "Platforms"
	root.add_child(platforms)

	# Coins container
	var coins = Node2D.new()
	coins.name = "Coins"
	root.add_child(coins)

	# Player (instantiated scene)
	var player_scene: PackedScene = load("res://scenes/player.tscn")
	var player = player_scene.instantiate()
	player.name = "Player"
	player.position = Vector2(200.0, 600.0)
	root.add_child(player)

	# HUD CanvasLayer
	var canvas = CanvasLayer.new()
	canvas.name = "HUD"
	canvas.layer = 1
	root.add_child(canvas)

	var ctrl = Control.new()
	ctrl.name = "Control"
	ctrl.set_anchors_preset(15)  # full rect
	ctrl.anchor_right = 1.0
	ctrl.anchor_bottom = 1.0
	canvas.add_child(ctrl)

	var score_label = Label.new()
	score_label.name = "ScoreLabel"
	score_label.text = "SCORE: 0"
	score_label.position = Vector2(20.0, 16.0)
	score_label.size = Vector2(300.0, 60.0)
	ctrl.add_child(score_label)

	var win_label = Label.new()
	win_label.name = "WinLabel"
	win_label.text = ""
	win_label.position = Vector2(340.0, 260.0)
	win_label.size = Vector2(600.0, 200.0)
	win_label.visible = false
	ctrl.add_child(win_label)

	_set_owners(root, root)

	var packed = PackedScene.new()
	var err = packed.pack(root)
	if err != OK:
		push_error("Pack failed: " + str(err))
		quit(1)
		return

	err = ResourceSaver.save(packed, "res://scenes/main.tscn")
	if err != OK:
		push_error("Save failed: " + str(err))
		quit(1)
		return

	print("Saved: res://scenes/main.tscn")
	quit(0)

func _set_owners(node: Node, owner: Node) -> void:
	for c in node.get_children():
		c.owner = owner
		if c.scene_file_path.is_empty():
			_set_owners(c, owner)
