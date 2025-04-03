extends GutTest

var PongBall = load("res://scripts/pong_ball.gd")

func test_ball_speed_on_start():
	var ball = PongBall.new()
	
	ball._ready()
	
	assert_eq(ball.speed, 700, "Ball Speed must be 700 on start")


func test_initial_veloicity():
	var ball = PongBall.new()
	
	
	ball._ready()
	ball._on_Timer_timeout()
	
	assert_eq(ball.ball_velocity.length(), ball.speed, "Ball speed must be constant")
	


func test_wall_ball_collision(): #Needs to be finished
	var ball = PongBall.new()
	
	
	
	
	
	
