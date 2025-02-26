extends Area2D
class_name Ball

@onready var timer: Timer = $StartTimer

@export var initial_speed: int = 400
@export_range(0, 90, 0.1, "radians_as_degrees") var max_angle: float = deg_to_rad(70)
@export_range(0, 40, 0.1, "radians_as_degrees") var rand_angle_range: float = deg_to_rad(30)

var velocity: Vector2 = Vector2.ZERO
var start_direction: int = -1
var is_moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	if start_direction == -1:
		rotation_degrees += 180

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_moving:
		position += velocity * delta

func start_velocity():
	velocity = Vector2.ZERO
	velocity.x = start_direction
	
	velocity = get_new_velocity()
	
	velocity = velocity.normalized() * initial_speed

func get_new_velocity() -> Vector2:
	var new_angle: float = get_new_angle()
	
	var vec = Vector2(
		velocity.length() * cos(new_angle), 
		velocity.length() * sin(new_angle)
		)
		
	return vec

func get_new_angle() -> float:
	var rand_angle = randf_range(-rand_angle_range, rand_angle_range)
	return cap_angle(velocity.angle() + rand_angle)

func cap_angle(new_angle: float) -> float:
	
	# Angle reduction
	if new_angle <= - PI:
		new_angle += 2 * PI
	elif new_angle >= PI:
		new_angle -= 2 * PI
	
	# Angle capping
	# If going left
	if abs(new_angle) > PI / 2:
		if sign(new_angle) == 1:
			new_angle = max(new_angle, PI - max_angle)
		else:
			new_angle = min(new_angle, - PI + max_angle)
	# If going right
	else:
		new_angle = min(new_angle, max_angle)
		new_angle = max(new_angle, -max_angle)
	return new_angle

func _on_start_timer_timeout() -> void:
	start_velocity()
	is_moving = true
	
func _on_paddle_collision() -> void:
	# Flip ball velocity
	velocity.x *= -1.1
	velocity = get_new_velocity()
	rotation_degrees += 180 % 360

func _on_border_collision() -> void:
	velocity.y *= -1
