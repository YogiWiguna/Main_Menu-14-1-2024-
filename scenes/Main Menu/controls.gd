extends TabBar

@onready var input_button_scene = preload("res://scenes/Action Button/input_button.tscn")
@onready var action_list = $Control/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList



var is_remapping = false
var action_to_remap = null
var remapping_button = null


var input_actions = {
	"move_up": "Move Up",
	"move_down": "Move Down",
	"move_right": "Move Right",
	"move_left": "Move Left",
	"interact": "Interact"
}


func _ready():
	creation_action_list()
	

func creation_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var label_input = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		print("Events :")
		print(events[0])
		if events.size() > 0:
			label_input.text = events[0].as_text().trim_suffix(" (Physical)")
		else: 
			label_input.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."

func _input(event):
	if is_remapping:
		if (
			# Input Key with Keyboard or Mouse Button 
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			# Turn double click into single click
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_lists(remapping_button, event)
			
			
			Persistence.config.set_value("Controls", action_to_remap, event)
			Persistence.save_data()
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			

func _update_action_lists(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")


func _on_reset_button_pressed():
	creation_action_list()
