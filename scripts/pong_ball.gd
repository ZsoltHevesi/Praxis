extends CharacterBody2D

var speed = 700.0

func _ready() -> void:
	velocity = Vector2(0, -speed)

func _physics_process(delta: float) -> void:
	# Move the ball with frame-rate independence
	var col : KinematicCollision2D = move_and_collide(velocity * delta)
	if col:
		var normal := col.get_normal()
		velocity = velocity.bounce(normal)
	
	# Get the screen size
	var screen_size = get_viewport_rect().size

	# Check for collision with the left or right edge of the screen
	if position.x <= 0 or position.x >= screen_size.x:
		velocity.x = -velocity.x
		position.x = clamp(position.x, 0, screen_size.x)

	# Check for collision with the top or bottom edge of the screen
	if position.y <= 0 or position.y >= screen_size.y:
		velocity.y = -velocity.y
		position.y = clamp(position.y, 0, screen_size.y)
