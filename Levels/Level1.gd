extends BaseLevel

const BallClass = preload("res://Objects/Ball.gd")

var ball
var checkpoints = []

func _ready():
	ball = create_ball($StartPosition.position)

	for i in range($Checkpoints.get_child_count()):
		var child = $Checkpoints.get_child(i)
		if i == 0:
			child.show()
		else:
			child.hide()
		child.connect("body_entered", self, "_on_checkpoint_entered", [child])
		checkpoints.append(child)

func _on_checkpoint_entered(ball, checkpoint):
	if ball is BallClass:
		_on_ball_entered(ball, checkpoint)

func _on_ball_entered(ball, checkpoint):
	checkpoint.hide()

	if checkpoints.size() == 1:
		print("Finished the level")
	else:	
		checkpoints.erase(checkpoint)
		checkpoints[0].show()

func _on_ball_screen_exited():
	delete_ball(ball)
	ball = create_ball($StartPosition.position)