extends CharacterBody2D

var speed = 700.0
var ball_velocity = Vector2()
var countdown_time = 4.0
var timer_label: Label
var go_display_time = 1.0

func _ready() -> void:
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y / 2
	# Reference the existing TimerLabel node
	timer_label = $"../../TimerLabel"
	if timer_label:
		timer_label.text = str(int(countdown_time))
		timer_label.show()
	else:
		print("Error: TimerLabel node not found")

	# Create and configure the timer
	var timer = Timer.new()
	timer.wait_time = countdown_time
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()

	# Start the countdown
	set_process(true)

func _process(delta: float) -> void:
	# Update the countdown timer
	if countdown_time > 1:
		countdown_time -= delta
		if timer_label:
			timer_label.text = str(int(countdown_time))
	elif countdown_time > 0:
		countdown_time -= delta
		if timer_label:
			timer_label.text = "Go!"
	elif go_display_time > 0:
		go_display_time -= delta
	else:
		if timer_label:
			timer_label.hide()
		set_process(false)

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
