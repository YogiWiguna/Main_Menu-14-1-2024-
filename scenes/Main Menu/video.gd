extends TabBar


func _ready():
	var screen_type = Persistence.config.get_value("Video", "Fullscreen")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%Fullscreen.button_pressed = true
	
	var borderless = Persistence.config.get_value("Video", "Borderless")
	if borderless == true:
		%Borderless.button_pressed = true
	
	var vsync_index = Persistence.config.get_value("Video", "Vsync")
	%Vsync.selected = vsync_index

func _on_fullscreen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video", "Fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video", "Fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	
	Persistence.save_data()

func _on_borderless_toggled(button_pressed):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, button_pressed)
	Persistence.config.set_value("Video", "Borderless", button_pressed)
	Persistence.save_data()
	


func _on_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	Persistence.config.set_value("Video", "Vsync", index)
	Persistence.save_data()


