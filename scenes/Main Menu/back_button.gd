extends Button

@onready var settings = $"../.."
@onready var main_menu = get_node("/root/MainMenu/UI/MainMenu")


func _on_pressed():
	settings.hide()
	main_menu.show()
