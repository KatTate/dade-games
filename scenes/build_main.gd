extends SceneTree
## Scene builder — run: timeout 60 godot --headless --script scenes/build_main.gd

func _initialize() -> void:
	var root = Node2D.new()
	root.name = "Main"
	root.set_script(load("res://scripts/game_manager.gd"))

	# Platforms container
	var platforms = Node2D.new()
	platforms.name = "Platforms"
	root.add_child(platforms)

	# Coins container
	var coins = Node2D.new()
	coins.name = "Coins"
	root.add_child(coins)

	# Player
	var player = load("res://scenes/player.tscn").instantiate()
	player.name = "Player"
	root.add_child(player)

	# HUD CanvasLayer
	var canvas = CanvasLayer.new()
	canvas.name = "HUD"
	canvas.layer = 1
	root.add_child(canvas)

	var ctrl = Control.new()
	ctrl.name = "Control"
	ctrl.set_anchors_preset(15)
	canvas.add_child(ctrl)

	var score_label = Label.new()
	score_label.name = "ScoreLabel"
	score_label.text = "SCORE: 0"
	score_label.position = Vector2(20, 20)
	ctrl.add_child(score_label)

	var win_label = Label.new()
	win_label.name = "WinLabel"
	win_label.text = ""
	win_label.set_anchors_preset(8)  # center
	win_label.visible = false
	ctrl.add_child(win_label)

	_set_owners(root, root)
	var packed = PackedScene.new()
	packed.pack(root)
	ResourceSaver.save(packed, "res://scenes/main.tscn")
	print("Saved: res://scenes/main.tscn")
	quit(0)

func _set_owners(node: Node, owner: Node) -> void:
	for c in node.get_children():
		c.owner = owner
		if c.scene_file_path.is_empty():
			_set_owners(c, owner)
