extends Node2D

func _on_StartGameButton_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_AboutButton_pressed():
	get_tree().change_scene("res://Screens/AboutScreen.tscn")
