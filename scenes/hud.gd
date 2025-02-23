extends CanvasLayer

@onready var label_1: Label = $Player1Score
@onready var label_2: Label = $Player2Score

var goal_label: PackedScene = load("res://scenes/goal_label.tscn")

var labels: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.goal_scored_by.connect(increase_score)
	labels = {
		1: label_1,
		2: label_2
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func increase_score(player_id: int) -> void:
	print("Goal from %s" % player_id)
	labels[player_id].increase_score()
	
