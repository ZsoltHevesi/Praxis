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
	assert_gt(paddle.position.y, 0, "Paddle has not rendered in the bottom half of the page")
	
func test_paddle_boundaries() -> void:
	print("theres nothing here yet")
	#paddle.position.x = 
	
	
func test_paddle_touch_input() ->void:
	print("paddle tests for touch input")
	
	paddle.speed = 1000;
	var starting_posiiton = paddle.position.x;
	var touch = InputEventScreenTouch.new()
	touch.pressed = true
	touch.position = Vector2(300, paddle.position.y)
	
	paddle._input(touch)
	for i in range(5):
		paddle._physics_process(1.0/60.0)
	assert_gt(paddle.position.x, 0, "Paddle has not moved on touch input")
	

	
	
