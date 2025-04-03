extends CharacterBody2D

var speed = 700.0
var ball_velocity = Vector2()

func _ready() -> void:
	# Create and configure the timer
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()

func _on_Timer_timeout() -> void:
	# Generate a random angle between -30 and 30 degrees or between 150 and 210 degrees
	var angle = randf_range(-45, 45)
	if randi() % 2 == 0:
		angle += 180
	angle = deg_to_rad(angle)
	
	# Set the initial ball_velocity based on the random angle
	ball_velocity = Vector2(sin(angle), cos(angle)) * speed

func _physics_process(delta: float) -> void:
	# Move the ball with frame-rate independence
	if ball_velocity != Vector2():
		var col : KinematicCollision2D = move_and_collide(ball_velocity * delta)
		if col:
			var normal := col.get_normal()
			ball_velocity = ball_velocity.bounce(normal)
		
		# Get the screen size
		var screen_size = get_viewport_rect().size

		# Check for collision with the left or right edge of the screen
		if position.x <= 0 or position.x >= screen_size.x:
			ball_velocity.x = -ball_velocity.x
			position.x = clamp(position.x, 0, screen_size.x)

		# Check for collision with the top or bottom edge of the screen
		if position.y <= 0 or position.y >= screen_size.y:
			ball_velocity.y = -ball_velocity.y
			position.y = clamp(position.y, 0, screen_size.y)
