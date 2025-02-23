extends Sprite2D

var noise = load("res://resources/background/background_noise.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	noise.noise.offset.x += 0.1
