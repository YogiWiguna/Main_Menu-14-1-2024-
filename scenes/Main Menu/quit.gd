extends Button

@onready var audio_stream_player_2d = $"../AudioStreamPlayer2D"


func _on_pressed():
	get_tree().quit()
	audio_stream_player_2d.play()

func _on_mouse_entered():
	audio_stream_player_2d.play()



func _on_mouse_exited():
	audio_stream_player_2d.stream_paused = true
