extends Node

@onready var main_buttons = $MainButtons
@onready var options = $Options

# Called when the node enters the scene tree for the first time.
func _ready():
	main_buttons.visible = true
	options.visible = false

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Level_1.tscn")

func _on_options_pressed():
	main_buttons.visible = false
	options.visible = true

func _on_exit_pressed():
	get_tree().quit()


func _on_back_options_pressed():
	_ready()
