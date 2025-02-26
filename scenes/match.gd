extends Node2D

@onready var player_1: Paddle = $Paddle
@onready var player_2: Paddle = $Paddle2
@onready var label_1: Label = $HUD/Player1Score
@onready var label_2: Label = $HUD/Player2Score
@onready var goal_label: GoalLabel = $HUD/GoalLabel

var players: Dictionary 
var labels: Dictionary
var screen_size: Vector2i
var t: float = 0
var last_goal_by = 1
var ball: Ball
var mode: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mode == "single_player":
		player_2.player_type = "Bot"
	elif mode == "two_players":
		player_2.player_type = "Player"
	
	player_1.update_movement()
	player_2.update_movement()
	
	players = {1: player_1, 2: player_2}
	labels = {1: label_1, 2: label_2}
	screen_size = get_viewport_rect().size
	
	# Connect signals for when a goal is scored
	for goal in get_tree().get_nodes_in_group("goal_areas"):
		goal.goal_by_player.connect(_on_goal_by_player)
		
	# Connect signal for starting new ball when goal finishes
	goal_label.finished_goal.connect(_on_goal_label_finished_goal)
	
	spawn_ball(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_ball(player_id) -> void:
	ball = load("res://scenes/ball.tscn").instantiate()
	ball.position = screen_size / 2
	ball.start_direction = -1 if player_id == 1 else 1
	add_child(ball)


func _on_goal_by_player(player_id: int) -> void:
	goal_label.show_goal_label()
	players[player_id].increase_score()
	labels[player_id].increase_score()
	last_goal_by = player_id
	ball.queue_free()

func _on_goal_label_finished_goal() -> void:
	if player_1.score == 5:
		game_won(player_1.player_id)
	elif player_2.score == 5:
		game_won(player_2.player_id)
	else:
		spawn_ball(last_goal_by)
	
func game_won(player_id: int) -> void:
	var win_screen: WinScreen = load("res://scenes/win_screen.tscn").instantiate()
	win_screen.winner_id = player_id
	get_tree().root.add_child(win_screen)
	get_tree().root.remove_child(self)
	
