extends InputMovement

class_name PlayerInputMovement

func _physics_process(delta):
	var speed: int = 0
	if Input.is_action_pressed("move_down_%s" % actor.player_id):
		speed += 1
	if Input.is_action_pressed("move_up_%s" % actor.player_id):
		speed -= 1

	actor.speed = speed
