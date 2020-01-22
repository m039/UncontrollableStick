extends Node

class_name BaseLevel

export (PackedScene) var Ball

func _on_ball_screen_exited():
	pass

func create_ball(pos):
	var b = Ball.instance()
	add_child(b)
	b.connect("screen_exited", self, "_on_ball_screen_exited")
	b.position = pos
	return b

func delete_ball(b):
	b.queue_free()