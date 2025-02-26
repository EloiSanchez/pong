extends Area2D

class_name GoalArea

signal goal_by_player(player_id: int)

@export var goal_id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(ball: Ball) -> void:
	goal_by_player.emit(goal_id)
