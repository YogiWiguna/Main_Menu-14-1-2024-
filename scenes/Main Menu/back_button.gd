extends Button

@onready var audio_stream_player_2d = $"../../AudioStreamPlayer2D"

func _on_pressed():
	Global.settings_ui.hide()
	Global.settings.show()
	audio_stream_player_2d.play()
