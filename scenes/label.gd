extends Label

@export var player_id: int

var score: int
var base_text: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	base_text = "Player %s: " % player_id + "%s"
	text = base_text % score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func increase_score():
	score += 1
	text = base_text % score
	
