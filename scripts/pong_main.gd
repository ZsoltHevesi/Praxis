extends Control

func _ready() -> void:
	# Reference the Area2D nodes
	var top_scoring_area = $LoseTop
	var bottom_scoring_area = $LoseBottom

	# Connect the body_entered signals to the scoring function
	top_scoring_area.connect("body_entered", Callable(self, "_on_ScoringArea_body_entered"))
	bottom_scoring_area.connect("body_entered", Callable(self, "_on_ScoringArea_body_entered"))

	# Set the size and position of the scoring areas
	var screen_size = get_viewport_rect().size
	top_scoring_area.position = Vector2(screen_size.x / 2, screen_size.y / 24)
	bottom_scoring_area.position = Vector2(screen_size.x / 2, screen_size.y * 23 / 24)

	var top_shape = top_scoring_area.get_node("CollisionShape2D").shape as RectangleShape2D
	var bottom_shape = bottom_scoring_area.get_node("CollisionShape2D").shape as RectangleShape2D

	top_shape.extents = Vector2(screen_size.x / 2, screen_size.y / 24)
	bottom_shape.extents = Vector2(screen_size.x / 2, screen_size.y / 24)

func _on_ScoringArea_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		print("Score!")
		# Add your scoring logic here
