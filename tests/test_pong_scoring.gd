extends GutTest

#Preload scripts before running tests 
var Game_Area = preload("res://scripts/pong_area.gd")
var Pong_Ball = preload("res://scripts/pong_ball.gd")
var Pong_Main = preload("res://scripts/pong_main.gd")
var Player_Paddle = preload("res://scripts/player_paddle.gd")

#PreLoad pong scene to allow for physics testing
var Pong_Scene = preload("res://scenes/pong_double.tscn")
#Declare ball node
var pong_ball: Node 
var pong_main: Control
var paddle: StaticBody2D
var ball: CharacterBody2D

#Code to be run before each test (built in feature of GUT)
func before_each() -> void:
	print("starting ball physics test")
	#Instantiate a new version of the scene
	var scene = Pong_Scene.instantiate()
	add_child_autofree(scene)
	scene.get_viewport().size = Vector2(720,1280)
	
	pong_main = scene.get_node(".")  # Or whatever your root node is named
	paddle = scene.get_node("objectLayer/playerPaddle")
	pong_ball = scene.get_node("objectLayer/pongBall")

	
	#run _ready() function from the pong_ball.gd
	pong_main._ready()
	pong_ball._ready()
	paddle._ready()
	
#Built in function in GUT run after each tests 
func after_each() -> void:
	#freeing all of our nodes and prerendered content to avoid orphans
	pong_ball.free()


func test_on_start_score_0():
	assert_eq(pong_main.score, 0, "Score should start at 0")
	
	
func test_high_score_updates():
	pong_main.high_score = 10
	pong_main.score = 20
	assert_eq(pong_main.score, 20, "Current score should be 20 ")
	assert_eq(pong_main.high_score, 10, "Current high score should be 10")
	
	
	pong_main._on_ScoringArea_body_entered(pong_ball)
	
	assert_eq(pong_main.high_score, 20, "High Score did not update on new high score reached")

	
func test_high_score_saved():
	print("testing high scores")
	
	var file = FileAccess.open("user://pong_high_score.save", FileAccess.READ)
	if file:
		var saved_high_score = file.get_var()
		file.close()
		assert_eq(saved_high_score, 20, "High score should be saved to file")
	
	

func test_score_increment_on_hit():
	#Currently throws an error because of trouble with paddle calls
	pong_main.score = 0
	var starting_score = pong_main.score
	
	paddle._on_area_2d_body_entered(pong_ball)
	
	assert_eq(pong_main.score, starting_score+1, "Score hasnt incremented")
	
	
	
	
