extends CharacterBody2D

var speed = 10.0

func _ready() -> void:
	velocity = Vector2(0, -speed)

func _physics_process(delta: float) -> void:
	var col : KinematicCollision2D = move_and_collide(velocity)
	if col:
		var normal := col.get_normal()
		velocity = velocity.bounce(normal)
