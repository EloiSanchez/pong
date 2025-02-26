class_name WinScreen
extends Control

@export var winner_id: int

@onready var label: Label = $ColorRect/ColorRect2/PlayerLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Player %s" % winner_id


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
