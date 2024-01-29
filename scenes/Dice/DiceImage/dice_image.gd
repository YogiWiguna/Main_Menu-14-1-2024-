extends Control

var rng = RandomNumberGenerator.new()
@onready var image = $Background/Image

var dice_image = [
	load("res://icon.svg"),
	load("res://Assets/DiceImage/seed_0.png"),
	load("res://Assets/DiceImage/seed_1.png"),
	load("res://Assets/DiceImage/seed_2.png"),
	load("res://Assets/DiceImage/seed_3.png"),
	load("res://Assets/DiceImage/seed_4.png")
]

func _on_roll_button_pressed():
	rng.randomize()
	var dice = rng.randi_range(1,6)
	image.texture = dice_image[dice-1]
	print(dice-1)
