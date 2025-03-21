extends CharacterBody2D

var SPEED := 800.0

func getXDir() -> float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")

func _physics_process(delta: float) -> void:
	var dir :Vector2=Vector2(getXDir(), 0)
	velocity = dir * SPEED
	move_and_slide()
