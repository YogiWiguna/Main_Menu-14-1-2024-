extends Button

@onready var main_menu = %MainMenu
@onready var settings_ui = $"../../Settings_UI"

func _ready():
	Global.settings = main_menu
	Global.settings_ui = settings_ui

func _on_pressed():
	settings_ui.show()
	get_parent().hide()
