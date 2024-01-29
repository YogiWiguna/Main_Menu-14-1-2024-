extends TabContainer

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _on_tab_clicked(tab):
	audio_stream_player_2d.play()
