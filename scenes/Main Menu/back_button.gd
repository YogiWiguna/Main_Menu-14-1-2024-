extends Button

@onready var settings = $"../.."
@onready var main_menu = get_node("/root/MainMenu/UI/MainMenu")
@onready var pause_menu = get_node("/root/Level/Pause/PauseMenu")


func _on_pressed():
	settings.hide()
	Global.settings.show()
	
