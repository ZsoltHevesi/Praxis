extends GutTest

#Preload scripts before running tests 
var Game_Area = preload("res://scripts/pong_area.gd")
var Paddle = preload("res://scenes/player_paddle.tscn")
var Pong_Scene = preload("res://scenes/pong_double.tscn")
#PreLoad pong scene to allow for physics testing



#Code to be run before each test (built in feature of GUT)
func before_each() -> void:
	print("starting ball physics test")
	#Instantiate a new version of the scene
	var scene = Pong_Scene.instantiate()
	#Create child node of scene
	add_child_autofree(scene)
	#Set testing viewport for walls the ball can bounce off 
	scene.get_viewport().size = Vector2(720,1280)
	
	var paddle_instance = Paddle.instantiate()

	add_child_autofree(paddle_instance)
	paddle_instance.position = Vector2(0, 500) 
	
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.extents = Vector2(50, 10) 
	paddle_instance.add_child(collision_shape)
	paddle_instance._ready()
	
func test_paddle_movement_on_input():
	paddle_instance.speed = 1000;
	var starting_posiiton = paddle.position.x;
	var touch = InputEventScreenTouch.new()
	touch.pressed = true
	touch.position = Vector2(300, paddle.position.y)
	
	paddle._input(touch)
	for i in range(5):
		paddle._physics_process(1.0/60.0)
	assert_gt(paddle.position.x, 0, "Paddle has not moved on touch input")
	
	

	

	
