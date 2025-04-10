extends GutTest

#Preload scripts before running tests 
var Game_Area = preload("res://scripts/pong_area.gd")
var Pong_Ball = preload("res://scripts/pong_ball.gd")
var Paddle = preload("res://scenes/player_paddle.tscn")
var Pong_Scene = preload("res://scenes/pong_double.tscn")
#PreLoad pong scene to allow for physics testing

#Declare ball node
var pong_ball: Node 


#Code to be run before each test (built in feature of GUT)
func before_each() -> void:
	print("starting ball physics test")
	#Instantiate a new version of the scene
	var scene = Pong_Scene.instantiate()
	#Create child node of scene
	add_child_autofree(scene)
	#Set testing viewport for walls the ball can bounce off 
	scene.get_viewport().size = Vector2(720,1280)
	#get the node for the pong ball to test collisions
	pong_ball = scene.get_node("objectLayer/pongBall")
	#run _ready() function from the pong_ball.gd
	pong_ball._ready()
	
#Built in function in GUT run after each tests 
func after_each() -> void:
	#freeing all of our nodes and prerendered content to avoid orphans
	pong_ball.free()
	
	

func test_ball_paddle_collision():
	#Create paddle instance
	var paddle_instance = Paddle.instantiate()

	add_child_autofree(paddle_instance)
	paddle_instance.position = Vector2(0, 500) 
	
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.extents = Vector2(50, 10)  
	paddle_instance.add_child(collision_shape)

	
	# Set ball position above paddle and moving downward
	pong_ball.position = Vector2(0, 400)
	pong_ball.ball_velocity = Vector2(0, 500)  
	
	var ball_position_y = pong_ball.position.y
	
	#Pass 10 frames 
	for i in range(10):
		pong_ball._physics_process(1.0/60.0)
		
	#Asserttion 	
	assert_gt(pong_ball.position.y, ball_position_y, "ball has not collided with paddle")
	
	
