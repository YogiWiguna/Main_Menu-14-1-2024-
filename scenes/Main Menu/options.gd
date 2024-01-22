extends Button

@onready var settings = %Settings
@onready var main_menu = %MainMenu

func _ready():
	Global.settings = main_menu

func _on_pressed():
	settings.show()
	get_parent().hide()
