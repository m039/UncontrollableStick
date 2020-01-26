extends RigidBody2D

export (float) var angularVelocity = 2

var input_enabled : bool = false

func _physics_process(delta):
	if !input_enabled:
		return;

	if Input.is_action_pressed("ui_right"):
		rotation += angularVelocity * delta
	elif Input.is_action_pressed("ui_left"):
		rotation -= angularVelocity * delta

func set_input_enabled(value : bool):
	input_enabled = value

func set_alpha(value : float):
	$Sprite.modulate.a = value


func set_visibility(value : bool):
	$CollisionShape.set_deferred("disabled", !value)

	if value:
		set_alpha(1)
	else:
		set_alpha(0.5)
