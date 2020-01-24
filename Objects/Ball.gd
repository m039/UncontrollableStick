extends RigidBody2D

class_name Ball

signal screen_exited

enum State {
	NORMAL, 
	ACTIVE
}

export (Color) var smallDotNormalColor = Color(0, 0, 0, 1)

export (Color) var smallDotActiveColor = Color(0, 0, 1, 1)

func _ready():
	set_state(State.NORMAL)

func _on_VisibilityNotifier_screen_exited():
	emit_signal("screen_exited")

func set_state(state):
	match state:
		State.NORMAL:
			$SmallDot.modulate = smallDotNormalColor
		State.ACTIVE:
			$SmallDot.modulate = smallDotActiveColor