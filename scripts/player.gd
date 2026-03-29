extends CharacterBody2D
## res://scripts/player.gd — Player controller with walk, jump, procedural drawing

const SPEED: float = 320.0
const JUMP_VELOCITY: float = -950.0
const GRAVITY: float = 1800.0

# Animation state
var _facing_right: bool = true
var _is_on_floor_cached: bool = false
var _anim_frame: int = 0
var _anim_timer: float = 0.0
var _leg_phase: float = 0.0
const ANIM_SPEED: float = 0.12

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var dir: float = Input.get_axis("move_left", "move_right")
	if abs(dir) > 0.1:
		velocity.x = dir * SPEED
		_facing_right = dir > 0.0
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED * 3.0 * delta)

	move_and_slide()
	_is_on_floor_cached = is_on_floor()

	# Walk animation
	if abs(velocity.x) > 20.0 and _is_on_floor_cached:
		_leg_phase += delta * 8.0
	queue_redraw()

func _draw() -> void:
	var body_color = Color(1.0, 0.55, 0.0)     # orange
	var dark_orange = Color(0.8, 0.35, 0.0)    # darker orange for outline
	var eye_white = Color.WHITE
	var eye_dark = Color(0.1, 0.1, 0.1)
	var feet_color = Color(0.8, 0.35, 0.0)

	# Body (main circle)
	draw_circle(Vector2.ZERO, 28.0, dark_orange)
	draw_circle(Vector2.ZERO, 26.0, body_color)

	# Eyes
	var eye_offset_x: float = 8.0 if _facing_right else -8.0
	# Left eye (relative to facing)
	draw_circle(Vector2(eye_offset_x - 4.0, -8.0), 6.0, eye_white)
	draw_circle(Vector2(eye_offset_x + 4.0, -8.0), 6.0, eye_white)
	# Pupils
	var pupil_dir: float = 2.0 if _facing_right else -2.0
	draw_circle(Vector2(eye_offset_x - 4.0 + pupil_dir, -8.0), 3.0, eye_dark)
	draw_circle(Vector2(eye_offset_x + 4.0 + pupil_dir, -8.0), 3.0, eye_dark)

	# Smile
	var smile_pts = PackedVector2Array()
	for i in range(7):
		var t: float = float(i) / 6.0
		var angle: float = deg_to_rad(200.0 + t * 140.0)
		smile_pts.append(Vector2(cos(angle) * 14.0 * (1.0 if _facing_right else -1.0), sin(angle) * 12.0 + 4.0))
	for i in range(smile_pts.size() - 1):
		draw_line(smile_pts[i], smile_pts[i + 1], eye_dark, 2.0)

	# Legs (animated when walking)
	var leg_swing: float = sin(_leg_phase) * 10.0
	var lx: float = -8.0
	var rx: float = 8.0
	if not _facing_right:
		lx = 8.0
		rx = -8.0
	draw_line(Vector2(lx, 20.0), Vector2(lx + leg_swing, 36.0), feet_color, 5.0)
	draw_line(Vector2(rx, 20.0), Vector2(rx - leg_swing, 36.0), feet_color, 5.0)

	# Arms
	var arm_swing: float = sin(_leg_phase) * 8.0
	draw_line(Vector2(-22.0, -4.0), Vector2(-30.0, 6.0 + arm_swing), dark_orange, 4.0)
	draw_line(Vector2(22.0, -4.0), Vector2(30.0, 6.0 - arm_swing), dark_orange, 4.0)

	# Jump pose: arms up
	if not _is_on_floor_cached:
		draw_line(Vector2(-22.0, -4.0), Vector2(-32.0, -14.0), dark_orange, 4.0)
		draw_line(Vector2(22.0, -4.0), Vector2(32.0, -14.0), dark_orange, 4.0)
