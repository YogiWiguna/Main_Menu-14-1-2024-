extends TabBar

@onready var input_button_scene = preload("res://scenes/Action Button/input_button.tscn")
@onready var action_list = $Control/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList
@onready var audio_stream_player_2d = $"../AudioStreamPlayer2D"



var is_remapping = false
var action_to_remap = null
var remapping_button = null

# Dictionary for input map
var input_actions = {
	"move_up": "Move Up",
	"move_down": "Move Down",
	"move_right": "Move Right",
	"move_left": "Move Left",
	"interact": "Interact"
}

# Dictionary for mouse 
var mouse_description = {
	MOUSE_BUTTON_LEFT : "Left Mouse Button",
	MOUSE_BUTTON_NONE : "No Button Input",
	MOUSE_BUTTON_RIGHT : "Right Mouse Button",
	MOUSE_BUTTON_MIDDLE : "Middle Mouse Button",
	MOUSE_BUTTON_WHEEL_UP : "Mouse Wheel Up",
	MOUSE_BUTTON_WHEEL_DOWN : "Mouse Wheel Down",
	MOUSE_BUTTON_WHEEL_LEFT : "Mouse Wheel Left",
	MOUSE_BUTTON_WHEEL_RIGHT : "Mouse Wheel Right",
	MOUSE_BUTTON_XBUTTON1 : "Mouse Thumb Button 1",
	MOUSE_BUTTON_XBUTTON2 : "Mouse Thumb Button 2"
	}

func _ready():
	creation_action_list()
	

func creation_action_list():
	# Free all children in action_list
	for item in action_list.get_children():
		item.queue_free()
		
	
	# Check input map based on input actions dectionary
	for action in input_actions:
		# instantiate the input_button scene 
		var button = input_button_scene.instantiate()
		# search the node "LabelAction" based on button 
		var action_label = button.find_child("LabelAction")
		# search the node "LabelInput" based on button
		var label_input = button.find_child("LabelInput")
		# Get value in config file in "Contorls" object and action as the key
		var screen_type = Persistence.config.get_value("Controls", action)
		print(screen_type)
		# change the text on action_label into the match input_actions dictionary
		action_label.text = input_actions[action]
		
		# Get the Input map action based on the action variable
		var events = InputMap.action_get_events(action)
		#print("Event 0: ",events[0])
		#print("Events :")
		#print(events[0] is InputEventKey)
		#print(screen_type == InputEventKey)
		
		# Check if the size of events isgreater than 0
		if events.size() > 0:
			# Check if the first index of events is InputEventKey
			if events[0] is InputEventKey:
				#print("Input Event Key")
				# Change the text from label_input based on the number from screen_type physical_keycode 
				# and than from that number change in into the string
				label_input.text = OS.get_keycode_string(screen_type.physical_keycode)
				#print("Keycode :", label_input.text)
			# Check if the first index is of events is InputEventMouseButton
			elif events[0] is InputEventMouseButton :
				# Change the text from label_input based on the number from screen_type button_index
				# and form the index change the string base in the mouse_description dictionary
				label_input.text = mouse_description[screen_type.button_index]
				#print("Mouse : ", label_input.text)
				#print()
		# Put else if the event.size is 0
		else: 
			# Turn the text on the label_input into null string
			label_input.text = ""
		
		# Add the button scene into the action_list node
		action_list.add_child(button)
		# If button scene is pressed connect it into the _on_input_button_pressed function 
		# and take the button and action as the parameters
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
		
	

func _on_input_button_pressed(button, action):
	# Check if the is_remapping is false
	if !is_remapping:
		# Set the is_remapping into true
		is_remapping = true
		# Set the action_to_remap into the action variable from creation_action_list function
		action_to_remap = action
		# Set the remapping_button into the button variable from creation_action_list function
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."

func _input(event):
	# Check if is_remapping is true
	if is_remapping:
		# Check if the input is InputEventKey or InputEventMouseButton
		if (
			# Input Key with Keyboard or Mouse Button 
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			# Turn mouse double click into single click
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			# Erase the InputMap action based on the action_to_remap
			InputMap.action_erase_events(action_to_remap)
			# Add the new action InputMap based on the action_to_remap with event
			InputMap.action_add_event(action_to_remap, event)
			# Update the label input text with the event 
			_update_action_lists(remapping_button, event)
			# Set the value into Controls with action_to_remap as the key and event as the value
			Persistence.config.set_value("Controls", action_to_remap, event)
			# Save the data
			Persistence.save_data()
			
			# Set the variable into the default
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			# Accetp the event 
			accept_event()
			

func _update_action_lists(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")


func _on_reset_button_pressed():
	audio_stream_player_2d.play()
	# Erase all the current input map and load it from the default
	InputMap.load_from_project_settings()
	# Get all the input map action 
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			# Set the value into Controls, the key is action and the value is based on the default input map
			Persistence.config.set_value("Controls",action,InputMap.action_get_events(action)[0])
			# Save the data
			Persistence.save_data()
			print(action, InputMap.action_get_events(action))
	# Call the creation_action_list function to change the label_input text
	creation_action_list()
