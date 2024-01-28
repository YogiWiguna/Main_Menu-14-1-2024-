extends Node

const PATH = "user://settings.cfg"
var config = ConfigFile.new()
var label_input


func _ready():
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			config.set_value("Controls",action,InputMap.action_get_events(action)[0])
			
			#print(action)
			#print("set value :",InputMap.action_get_events(action)[0])
			#print(InputMap.action_get_events(action))
	
	
	config.set_value("Video", "Fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("Video", "Borderless", false)
	
	config.set_value("Video", "Vsync", DisplayServer.VSYNC_ENABLED)

	
	for i in range(3):
		config.set_value("Audio", str(i), 0.0)
	
	load_data()

func save_data():
	config.save(PATH)

func load_data():
	if config.load("user://settings.cfg") != OK:
		save_data()
		return
	
	load_control_settings()
	load_video_settings()

func load_control_settings():
	var keys = config.get_section_keys("Controls")
	#print("Keys : ",keys)
	for action in InputMap.get_actions():
		if keys.has(action):
			var value = config.get_value("Controls", action)
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, value)
	

func load_video_settings():
	var screen_type = config.get_value("Video", "Fullscreen")
	DisplayServer.window_set_mode(screen_type)
	
	var borderless = config.get_value("Video", "Borderless")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderless)
	
	var vsync_index = config.get_value("Video", "Vsync")
	DisplayServer.window_set_vsync_mode(vsync_index)
