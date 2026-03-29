extends SceneTree
## Scene builder — run: timeout 60 godot --headless --script scenes/build_player.gd

func _initialize() -> void:
	print("Building: player.tscn")

	var root = CharacterBody2D.new()
	root.name = "Player"
	root.set_script(load("res://scripts/player.gd"))
	root.collision_layer = 1   # layer 1 = player
	root.collision_mask = 4    # layer 3 = platforms bitmask 4

	var col = CollisionShape2D.new()
	col.name = "CollisionShape2D"
	var shape = CapsuleShape2D.new()
	shape.radius = 26.0
	shape.height = 52.0
	col.shape = shape
	root.add_child(col)

	_set_owners(root, root)

	var packed = PackedScene.new()
	var err = packed.pack(root)
	if err != OK:
		push_error("Pack failed: " + str(err))
		quit(1)
		return

	err = ResourceSaver.save(packed, "res://scenes/player.tscn")
	if err != OK:
		push_error("Save failed: " + str(err))
		quit(1)
		return

	print("Saved: res://scenes/player.tscn")
	quit(0)

func _set_owners(node: Node, owner: Node) -> void:
	for c in node.get_children():
		c.owner = owner
		if c.scene_file_path.is_empty():
			_set_owners(c, owner)
