extends SceneTree
## Test harness for Core Game task — captures screenshot of the game running

var _frame_count: int = 0
var _scene_root: Node = null
var _cam: Camera2D = null
var _initialized: bool = false

func _initialize() -> void:
	print("Test harness starting...")
	# Load and instance the main scene
	var main_scene: PackedScene = load("res://scenes/main.tscn")
	_scene_root = main_scene.instantiate()
	root.add_child(_scene_root)

	# Setup camera
	_cam = Camera2D.new()
	_cam.name = "TestCamera"
	_cam.zoom = Vector2(1.0, 1.0)
	_cam.position = Vector2(640.0, 360.0)
	_scene_root.add_child(_cam)

func _process(delta: float) -> bool:
	_frame_count += 1

	if not _initialized and _frame_count >= 2:
		_initialized = true
		_cam.make_current()

		# Verify platforms were spawned
		var platforms = _scene_root.get_node_or_null("Platforms")
		if platforms and platforms.get_child_count() > 0:
			print("ASSERT PASS: Platforms spawned count=", platforms.get_child_count())
		else:
			print("ASSERT FAIL: No platforms spawned")

		# Verify coins were spawned
		var coins = _scene_root.get_node_or_null("Coins")
		if coins and coins.get_child_count() > 0:
			print("ASSERT PASS: Coins spawned count=", coins.get_child_count())
		else:
			print("ASSERT FAIL: No coins spawned")

		# Verify player exists
		var player = _scene_root.get_node_or_null("Player")
		if player:
			print("ASSERT PASS: Player node found")
		else:
			print("ASSERT FAIL: Player not found")

		# Verify HUD score label
		var score_label = _scene_root.get_node_or_null("HUD/Control/ScoreLabel")
		if score_label and score_label.text.begins_with("SCORE:"):
			print("ASSERT PASS: Score label visible: ", score_label.text)
		else:
			print("ASSERT FAIL: Score label missing or wrong text")

	# Simulate some player movement to make the scene more interesting
	if _frame_count == 5:
		Input.action_press("move_right")
	if _frame_count == 15:
		Input.action_release("move_right")
		Input.action_press("jump")
	if _frame_count == 16:
		Input.action_release("jump")

	return false
