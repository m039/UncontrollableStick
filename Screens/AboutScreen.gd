extends Node2D

func _on_BackButton_pressed():
	get_tree().change_scene("res://Screens/MenuScreen.tscn")

func _on_TwitterButton_pressed():
	OS.shell_open("https://twitter.com/m0391n")