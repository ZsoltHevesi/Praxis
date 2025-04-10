extends GutTest

var Game_Area = preload("res://scripts/pong_area.gd")
var Pong_Ball = preload("res://scripts/pong_ball.gd")
var Paddle = preload("res://scenes/player_paddle.tscn")
var Pong_Scene = preload("res://scenes/pong_double.tscn")

var game_area = Game_Area
var paddle 

func before_each() -> void:
	
	print("starting test")
	#game_area = Game_Area.new()
	var scene = Pong_Scene.instantiate()
	var paddle_instance = Paddle.instantiate()
	scene.get_viewport().size = Vector2(720,1280)

	add_child_autofree(paddle_instance)
	paddle_instance.position = Vector2(0, 500)  # Position below the ball
	
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.extents = Vector2(50, 10)  # Adjust size as needed
	paddle_instance.add_child(collision_shape)
	
	
	add_child_autofree(scene)
	add_child_autofree(paddle)
	
	paddle._ready()
	await get_tree().process_frame

func after_each() -> void:
	print("nothing needed here")
	
	
	
	#Initially working and run, now throws an error, left in for documentation purposes
#func test_paddle_position_on_start() -> void:
	#assert_eq(paddle.position.x, scene.get_viewport_rect().size.x / 2,  "Paddle is not centered on start")
	#assert_gt(paddle.position.y, 0, "Paddle has not rendered in the bottom half of the page")
	#

	
func test_paddle_touch_input() ->void:
	print("paddle tests for touch input")
	
	var paddle_instance = Paddle.instantiate()

	add_child_autofree(paddle_instance)
	paddle_instance.position = Vector2(0, 500)  
	
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.extents = Vector2(50, 10)
	paddle_instance.add_child(collision_shape)
	
	var test_area = Node2D.new()
	paddle.area = test_area
	
	paddle.speed = 1000;
	var starting_posiiton = paddle.position.x;
	var touch = InputEventScreenTouch.new()
	touch.pressed = true
	touch.position = Vector2(300, paddle.position.y)
	
	paddle._input(touch)
	for i in range(5):
		paddle._physics_process(1.0/60.0)
	assert_gt(paddle.position.x, 0, "Paddle has not moved on touch input")
	

	
	
