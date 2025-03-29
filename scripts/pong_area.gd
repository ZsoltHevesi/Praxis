extends Area2D

@export var screen_position: float
@onready var collision = $CollisionShape2D

func _ready():
	# Ensure the platform starts at the bottom third of the screen
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y * 2 / screen_position
	
	collision.shape.set_size(Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y / 3.5))
