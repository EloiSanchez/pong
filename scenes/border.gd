extends Area2D

class_name Border

@export var color_1: Color
@export var color_2: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var packed_color_array: PackedColorArray = PackedColorArray()
	packed_color_array.append(color_1)
	packed_color_array.append(color_2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_area_entered(ball: Ball) -> void:
	ball._on_border_collision()
