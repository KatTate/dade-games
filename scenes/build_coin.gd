extends SceneTree
## Scene builder — run: timeout 60 godot --headless --script scenes/build_coin.gd

func _initialize() -> void:
	print("Building: coin.tscn")

	var root = Area2D.new()
	root.name = "Coin"
	root.set_script(load("res://scripts/coin.gd"))
	root.collision_layer = 2   # layer 2 = coins bitmask 2
	root.collision_mask = 1    # layer 1 = player bitmask 1

	var col = CollisionShape2D.new()
	col.name = "CollisionShape2D"
	var shape = CircleShape2D.new()
	shape.radius = 18.0
	col.shape = shape
	root.add_child(col)

	_set_owners(root, root)

	var packed = PackedScene.new()
	var err = packed.pack(root)
	if err != OK:
		push_error("Pack failed: " + str(err))
		quit(1)
		return

	err = ResourceSaver.save(packed, "res://scenes/coin.tscn")
	if err != OK:
		push_error("Save failed: " + str(err))
		quit(1)
		return

	print("Saved: res://scenes/coin.tscn")
	quit(0)

func _set_owners(node: Node, owner: Node) -> void:
	for c in node.get_children():
		c.owner = owner
		if c.scene_file_path.is_empty():
			_set_owners(c, owner)
