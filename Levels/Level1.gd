extends BaseLevel

const BallClass = preload("res://Objects/Ball.gd")

var ball
var checkpoints = []

func _ready():
	start_game()

func _on_restart():
	start_game()

func start_game():
	if ball != null:
		delete_ball(ball)

	ball = create_ball($StartPosition.position)
	checkpoints.clear()

	for i in range($Checkpoints.get_child_count()):
		var child = $Checkpoints.get_child(i)
		set_checkpoint_enabled(child, i == 0)
		child.disconnect("body_entered", self, "_on_checkpoint_entered")
		child.connect("body_entered", self, "_on_checkpoint_entered", [child])
		checkpoints.append(child)

func _on_checkpoint_entered(ball, checkpoint):
	if ball is BallClass:
		_on_ball_entered(ball, checkpoint)

func _on_ball_entered(ball, checkpoint):
	set_checkpoint_enabled(checkpoint, false)

	if checkpoints.size() == 1:
		print("Finished the level")
	else:	
		checkpoints.erase(checkpoint)
		set_checkpoint_enabled(checkpoints[0], true)

func set_checkpoint_enabled(checkpoint, value):
	checkpoint.set_collision_enabled(value)
	if (value):
		checkpoint.show()
	else:
		checkpoint.hide()