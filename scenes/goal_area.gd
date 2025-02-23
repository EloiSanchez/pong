extends Area2D

class_name GoalArea

@export var goal_id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(ball: Ball) -> void:
	SignalBus.goal_scored_by.emit(goal_id)
