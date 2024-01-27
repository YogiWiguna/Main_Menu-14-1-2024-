extends Control

var rng = RandomNumberGenerator.new()
@onready var number = $Background/Number


func _on_roll_button_pressed():
	rng.randomize()
	var dice = rng.randi_range(1,6)
	number.text = str(dice) 
	print(dice)

