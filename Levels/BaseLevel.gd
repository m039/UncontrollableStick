extends Node

class_name BaseLevel

export (PackedScene) var Ball

const BigMessage : PackedScene = preload("res://Objects/BigMessage.tscn")

const WinScreen : PackedScene = preload("res://Screens/WinScreen.tscn")

func show_big_message():
	var message = BigMessage.instance()
	add_child(message)
	return message

func show_win_screen():
	var screen = WinScreen.instance()
	add_child(screen)
	return screen

func _on_ball_screen_exited():
	_on_restart();

func _on_restart():
	pass

func create_ball(pos):
	var b = Ball.instance()
	add_child(b)
	b.connect("screen_exited", self, "_on_ball_screen_exited")
	b.position = pos
	return b

func delete_ball(b):
	b.queue_free()