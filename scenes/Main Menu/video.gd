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

# Check if the fullscreen button is pressed
func _on_fullscreen_toggled(button_pressed):
	# Check if the button is being pressed and it will call true and will run code inside
	if button_pressed:
		# Set window mode in DisplayServer into Fullscreen mode
		# in save data file (setting.cfg) the value off Fullscreen will be 3 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		# Set the value of current value (Fullscreen) in "Video" node and from "Fullscreen"
		# And later will be save on the config file save on Persistence script
		Persistence.config.set_value("Video", "Fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		# Check if the button is not being pressed or uncheck
		# in save data file (setting.cfg) the value off Fullscreen will be 0 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		# Set the value into the config file to save it 
		Persistence.config.set_value("Video", "Fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	
	# Save the data from value given from above
	Persistence.save_data()

## Check if the bordless button is pressed
func _on_borderless_toggled(button_pressed):
	# Set the Bordless window into bordless if the button_pressed is true
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, button_pressed)
	Persistence.config.set_value("Video", "Borderless", button_pressed)
	Persistence.save_data()
	


func _on_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	Persistence.config.set_value("Video", "Vsync", index)
	Persistence.save_data()


