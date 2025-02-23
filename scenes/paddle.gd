extends Area2D

class_name Paddle

@export var color: Color
@export var movement_stats: MovementStats
@export var player_id: int = 1
@export_enum("Player", "Bot") var player_type: String

@onready var line: Line2D = $Line2D

var speed: int = 0
var size: int
var input_movement
var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line.default_color = color
	if player_type == "Bot":
		pass
	elif player_type == "Player":
		var input_movement: PlayerInputMovement = load("res://resources/movement/player_input_movement.gd").new()
		input_movement.actor = self
		add_child(input_movement)
		
	size = abs(line.get_point_position(1).y - line.get_point_position(0).y)
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position.y += speed * movement_stats.movement_speed * delta
	
	position.y = max(size / 2, position.y)
	position.y = min(screen_size.y - size / 2, position.y)
	

func _on_area_entered(ball: Ball) -> void:
	ball._on_paddle_collision()
