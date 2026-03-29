extends Area2D
## res://scripts/coin.gd — Coin pickup with procedural drawing

signal collected

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		collected.emit()
		queue_free()

func _draw() -> void:
	# Gold coin circle
	var gold = Color(1.0, 0.85, 0.0)
	var dark_gold = Color(0.8, 0.6, 0.0)
	var bright_gold = Color(1.0, 1.0, 0.5)

	# Outer ring
	draw_circle(Vector2.ZERO, 18.0, dark_gold)
	# Inner body
	draw_circle(Vector2.ZERO, 15.0, gold)
	# Highlight
	draw_circle(Vector2(-4.0, -4.0), 5.0, bright_gold)

	# Star outline (5-pointed)
	var star_pts = PackedVector2Array()
	for i in range(10):
		var angle: float = deg_to_rad(-90.0 + float(i) * 36.0)
		var r: float = 10.0 if i % 2 == 0 else 5.0
		star_pts.append(Vector2(cos(angle) * r, sin(angle) * r))

	# Fill star
	var star_colors = PackedColorArray()
	for i in range(10):
		star_colors.append(Color(1.0, 0.7, 0.0))
	draw_polygon(star_pts, star_colors)
