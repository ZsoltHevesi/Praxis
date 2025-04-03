extends GutTest

#Preload scripts before running tests 
var Game_Area = preload("res://scripts/pong_area.gd")
var Pong_Ball = preload("res://scripts/pong_ball.gd")

#PreLoad pong scene to allow for physics testing
var Pong_Scene = preload("res://scenes/pong_double.tscn")
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

#Tests the initial speed of our ball is set to ensure consistency with each play
func test_ball_speed_on_start():

	assert_eq(pong_ball.speed, 700.00, "Ball Speed must be 700 on start")

#Test velocity is consistent so ball doesnt change speed without extenral factors 
func test_initial_veloicity():
	
	pong_ball._on_Timer_timeout()
	
	assert_eq(pong_ball.ball_velocity.length(), pong_ball.speed, "Ball speed must be constant")
	

#Test ball cannot escape the predetermined play area
func test_wall_ball_collision():
	
	pong_ball._on_Timer_timeout()
	#Leaving this here for now for future tests on velocity after collisions
	var initial_velocity = pong_ball.ball_velocity
	#Set velocity to be moving left for collision with left wall
	pong_ball.ball_velocity = Vector2(-500.0, 0.0)
	#Set balls initial x position to 0 so we can have collision take place immediately 
	pong_ball.position.x = 0.0
	
	#Allow the ball to move for five frames before assertion 
	for i in range(5):
		pong_ball._physics_process(1.0/60.0)
	
	assert_gt(pong_ball.position.x, 0.0, "ball has not moved away from the wall")
	
	
	
	
	
	
	
