extends Node2D

@onready var player_1: Area2D = $Paddle
@onready var player_2: Area2D = $Paddle2

var screen_size: Vector2i
var t: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.finished_goal.connect(on_finished_goal)
	screen_size = get_viewport_rect().size
	spawn_ball(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_ball(player_id) -> void:
	var ball: Ball = load("res://scenes/ball.tscn").instantiate()
	ball.position = screen_size / 2
	ball.start_direction = -1 if player_id == 1 else 1
	add_child(ball)

func on_finished_goal(player_id: int):
	spawn_ball(player_id)
