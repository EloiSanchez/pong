extends Area2D

class_name Paddle

@export var color: Color
@export var player_id: int = 1
@export_enum("Player", "Bot") var player_type: String

@onready var line: Line2D = $Line2D

var speed: float = 0
var size: int
var input_movement: InputMovement
var screen_size: Vector2
var score = 0
#var movement_stats_res: MovementStats = load("res://resources/movement/movement_stats.gd")
var movement_stats
var movement_speed: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line.default_color = color	
		
	size = abs(line.get_point_position(1).y - line.get_point_position(0).y)
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position.y += movement_stats.movement_speed * speed * delta
	
	position.y = max(size / 2, position.y)
	position.y = min(screen_size.y - size / 2, position.y)

func increase_score():
	score += 1

func _on_area_entered(ball: Ball) -> void:
	ball._on_paddle_collision()

func update_movement():
	if player_type == "Bot":
		input_movement = load("res://resources/movement/bot_input_movement.gd").new()
		movement_stats = load("res://resources/movement/bot_movement_stats.tres")
	elif player_type == "Player":
		input_movement = load("res://resources/movement/player_input_movement.gd").new()
		movement_stats = load("res://resources/movement/player_movement_stats.tres")
	movement_speed = movement_stats.movement_speed
	input_movement.actor = self
	add_child(input_movement)
