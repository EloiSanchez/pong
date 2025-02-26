class_name BotInputMovement
extends InputMovement


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ball: Ball = get_tree().get_first_node_in_group("ball")
	var y: int
	if ball:
		y = ball.position.y
		#print("ball found. y %s" % y)
	else:
		y = actor.screen_size.y / 2
		#print("ball not found. y %s" % y)
	
	var diff = y - actor.position.y
	var speed: float = sign(diff)
	
	if abs(diff) < 10:
		speed *= abs(diff / 10)
		#print("Speed scaled %s" % speed)
		
	

	actor.speed = speed
