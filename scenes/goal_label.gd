extends Label

class_name GoalLabel

@onready var timer: Timer = $Timer

@export var start_size: int = 60
@export var final_size: int = 80

@export var phase_in_time: float = 0.2
@export var show_time: float = 1
@export var phase_out_time: float = 0.2

var player_id: int
var t: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.goal_scored_by.connect(show_goal_label)
	
	timer.wait_time = phase_in_time + show_time + phase_out_time
	hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	var effective_t: float
	
	if t < phase_in_time:
		label_settings.font_size = start_size * t / phase_in_time
	elif phase_in_time <= t and t <= phase_in_time + show_time:
		effective_t = (t - phase_in_time) / show_time
		label_settings.font_size = start_size + effective_t * (final_size - start_size)
	elif phase_in_time + show_time < t:
		effective_t = (t - phase_in_time - show_time) / phase_out_time
		label_settings.font_size = (1 - effective_t) * final_size

func show_goal_label(_player_id: int):
	t = 0
	timer.start()
	show()

func _on_timer_timeout() -> void:
	SignalBus.finished_goal.emit(player_id)
	hide()
