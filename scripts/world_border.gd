extends Node2D

func _ready():
	var screen_size = get_viewport_rect().size

	# Set up the top border
	var top_border = $TopBorder
	top_border.position = Vector2(screen_size.x / 2, -5)
	var top_shape = top_border.get_node("CollisionShape2D").shape as RectangleShape2D
	top_shape.extents = Vector2(screen_size.x / 2, 10)

	# Set up the bottom border
	var bottom_border = $BottomBorder
	bottom_border.position = Vector2(screen_size.x / 2, screen_size.y + 5)
	var bottom_shape = bottom_border.get_node("CollisionShape2D").shape as RectangleShape2D
	bottom_shape.extents = Vector2(screen_size.x / 2, 10)

	# Set up the left border
	var left_border = $LeftBorder
	left_border.position = Vector2(-5, screen_size.y / 2)
	var left_shape = left_border.get_node("CollisionShape2D").shape as RectangleShape2D
	left_shape.extents = Vector2(10, screen_size.y / 2)

	# Set up the right border
	var right_border = $RightBorder
	right_border.position = Vector2(screen_size.x + 5, screen_size.y / 2)
	var right_shape = right_border.get_node("CollisionShape2D").shape as RectangleShape2D
	right_shape.extents = Vector2(10, screen_size.y / 2)
