extends Button

@onready var main_menu = %MainMenu
@onready var settings_ui = $"../../Settings_UI"
@onready var audio_stream_player_2d = $"../AudioStreamPlayer2D"

func _ready():
	Global.settings = main_menu
	Global.settings_ui = settings_ui

func _on_pressed():
	audio_stream_player_2d.play()
	settings_ui.show()
	get_parent().hide()


func _on_options_mouse_entered():
	audio_stream_player_2d.play()


func _on_options_mouse_exited():
	audio_stream_player_2d.stream_paused = true
