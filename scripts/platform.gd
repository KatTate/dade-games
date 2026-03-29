extends StaticBody2D
## res://scripts/platform.gd — Platform with procedural drawing

var platform_width: float = 200.0
var platform_height: float = 30.0

func _ready() -> void:
	# Setup collision shape
	var col = CollisionShape2D.new()
	col.name = "CollisionShape2D"
	var shape = RectangleShape2D.new()
	shape.size = Vector2(platform_width, platform_height)
	col.shape = shape
	add_child(col)

func _draw() -> void:
	var hw: float = platform_width * 0.5
	var hh: float = platform_height * 0.5
	# Brown body
	draw_rect(Rect2(-hw, -hh, platform_width, platform_height), Color(0.55, 0.35, 0.1), true)
	# Green top bar (12px tall)
	var top_h: float = 12.0
	draw_rect(Rect2(-hw, -hh, platform_width, top_h), Color(0.2, 0.75, 0.2), true)
	# Dark outline
	draw_rect(Rect2(-hw, -hh, platform_width, platform_height), Color(0.1, 0.1, 0.1), false, 2.0)
