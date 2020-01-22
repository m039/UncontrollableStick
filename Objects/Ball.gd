extends RigidBody2D

class_name Ball

signal screen_exited

func _on_VisibilityNotifier_screen_exited():
	emit_signal("screen_exited")