extends RigidBody2D

export (float) var angularVelocity = 2

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		rotation += angularVelocity * delta
	elif Input.is_action_pressed("ui_left"):
		rotation -= angularVelocity * delta