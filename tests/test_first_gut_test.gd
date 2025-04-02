extends GutTest

var PongBall = load("res://scripts/pong_ball.gd")

func test_ball_speed():
	var ball = PongBall.new()
	
	ball._ready()
	
	assert_eq(ball.speed, 15, "Test designed to fail, wrong ball speed --- This is a test of GUT")
