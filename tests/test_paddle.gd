extends GutTest

var Game_Area = preload("res://scripts/pong_area.gd")
var Paddle = preload("res://scripts/player_paddle.gd")

var game_area = Game_Area
var paddle = Paddle

func before_each() -> void:
	print("starting test")
	game_area = Game_Area.new()
	paddle = Paddle.new()
	#await get_tree().process_frame

func after_each() -> void:
	game_area.free()
	paddle.free()
	
	
func test_paddle_position_on_start() -> void:
	assert_eq(paddle.position.x, game_area.get_viewport_rect().size.x / 2,  "Paddle is not centered on start")
	
	
func test_paddle_boundaries() -> void:
	print("theres nothing here yet")
	#paddle.position.x = 
	
	
