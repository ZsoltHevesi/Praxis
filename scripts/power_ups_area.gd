extends Node2D

# Path to the powerup scene
var powerup_scene = preload("res://scenes/obstacle_cube.tscn")

# Timer to spawn powerups
var spawn_timer = Timer.new()

func _ready():
	# Add the timer to the scene
	add_child(spawn_timer)
	spawn_timer.wait_time = 15.0
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.start()

	# Set up the PowerupArea
	var screen_size = get_viewport_rect().size
	var powerup_area = $Area2D
	var collision_shape = powerup_area.get_node("CollisionShape2D").shape as RectangleShape2D

	# Calculate the extents and position for the PowerupArea
	collision_shape.extents = Vector2(screen_size.x * 3 / 8, screen_size.y / 16)
	powerup_area.position = Vector2(screen_size.x / 2, screen_size.y / 2)

func _on_spawn_timer_timeout():
	# Get the PowerupArea node
	var powerup_area = $Area2D
	var collision_shape = powerup_area.get_node("CollisionShape2D").shape as RectangleShape2D
	var area_position = powerup_area.global_position
	var area_rect = Rect2(area_position - collision_shape.extents, collision_shape.extents * 2)

	# Generate a random position within the area
	var random_position = Vector2(
		randf_range(area_rect.position.x, area_rect.position.x + area_rect.size.x),
		randf_range(area_rect.position.y, area_rect.position.y + area_rect.size.y)
	)

	# Instance the powerup scene and set its position
	var powerup_instance = powerup_scene.instantiate()
	powerup_instance.position = random_position
	add_child(powerup_instance)
