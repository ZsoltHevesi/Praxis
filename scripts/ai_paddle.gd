extends StaticBody2D

@export var screen_position: float
@onready var pong_double = $"../.."
var ball : CharacterBody2D


func _ready() -> void:
	ball = get_parent().get_node("pongBall")
	# Ensure the platform starts at the bottom third of the screen
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y * 2 / screen_position
	# Initialize target_position to the current position


func _process(delta):
	# Update the paddle's X position to follow the ball's X position
	global_position.x = ball.global_position.x


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		pong_double.score += 1
		pong_double.update_scores()
		pong_double.update_high_score_label()
	
