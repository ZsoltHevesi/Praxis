extends CharacterBody2D

# Speed of the platform movement
var speed = 1000
var target_position


func _ready():
	# Ensure the platform starts at the bottom third of the screen
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y * 2 / 2.2
	# Initialize target_position to the current position
	target_position = position.x

func _input(event):
	# Check for touchscreen tap input
	if event is InputEventScreenTouch and event.pressed:
		target_position = event.position.x

	# Check for touchscreen drag input
	if event is InputEventScreenDrag:
		target_position = event.position.x

func _process(delta):
	# Calculate the distance to the target position
	var distance = target_position - position.x
	# Calculate the direction to move
	var direction = sign(distance)
	# Move the platform towards the target position at the specified speed
	position.x += direction * speed * delta

	# Ensure the platform does not overshoot the target position
	if abs(distance) < speed * delta:
		position.x = target_position

	# Ensure the platform stays within the screen bounds
	position.x = clamp(position.x, 0, get_viewport_rect().size.x - $ColorRect.size.x)
