extends Control

@onready var settings = $"../../Setting/Settings"


var is_paused: bool = false:
	set = set_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		is_paused = !is_paused
		

func set_paused(value:bool):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	

func _on_resume_button_pressed():
	is_paused = false

func _on_setting_button_pressed():
	settings.show()
	self.hide()
	Global.settings = self
	
func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Main Menu/main_menu.tscn")
