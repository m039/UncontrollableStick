extends Node2D

func _ready():
	# Hide all stars
	for i in range($Stars.get_child_count()):
		$Stars.get_child(i).get_node("Normal").hide()

func set_number_of_stars(number : int):
	# Show stars according to the number.
	for i in range($Stars.get_child_count()):
		if number <= 0:
			break
		else:
			number -= 1
			$Stars.get_child(i).get_node("Normal").show()
