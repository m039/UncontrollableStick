extends Area2D

func set_collision_enabled(value):
	$CollisionShape.set_deferred("disabled", !value)