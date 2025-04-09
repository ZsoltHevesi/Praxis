extends Area2D

# Reference to the ball node
var ball


func _on_body_entered(body):
	if body is CharacterBody2D:
		ball = body
		ball.increase_speed(300, 5.0)
		queue_free()
		print("Speed!")
