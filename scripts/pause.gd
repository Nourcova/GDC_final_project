extends Node

@onready var pause_panel = %Pause_panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pause_pressed = Input.is_action_just_pressed("pause")
	if pause_pressed:
		get_tree().paused = true
		pause_panel.show()

func _on_resume_pressed():
	pause_panel.hide()
	get_tree().paused = false

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
