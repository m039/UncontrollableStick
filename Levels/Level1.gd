extends BaseLevel

const BallClass = preload("res://Objects/Ball.gd")

var ball
var ballActive : bool
var ballActiveCheckpoints : int = 0
var checkpoints = []
var stickActiveZones = []
var stickNormalZone

func _ready():
	stickActiveZones.append(get_node("Stick/Zones/ActiveZone1"))
	stickActiveZones.append(get_node("Stick/Zones/ActiveZone2"))
	stickNormalZone = get_node("Stick/Zones/NormalZone")
	
	start_game()

func _physics_process(delta):
	if ball.get_area().overlaps_area(stickNormalZone):
		ballActive = false
	else:
		for zone in stickActiveZones:
			if ball.get_area().overlaps_area(zone):
				ballActive = true
				break

	ball.set_active(ballActive)

func _on_restart():
	start_game()

func start_game():
	if ball != null:
		delete_ball(ball)

	ballActive = false
	ballActiveCheckpoints = 0

	ball = create_ball($StartPosition.position)
	ball.set_active(ballActive)
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

	if ballActive:
		ballActiveCheckpoints += 1

	if checkpoints.size() == 1:
		if ballActiveCheckpoints == 2:
			print("3 stars")
		elif ballActiveCheckpoints == 1:
			print("2 stars")
		else:
			print("1 stars")
	else:	
		checkpoints.erase(checkpoint)
		set_checkpoint_enabled(checkpoints[0], true)

func set_checkpoint_enabled(checkpoint, value):
	checkpoint.set_collision_enabled(value)
	if (value):
		checkpoint.show()
	else:
		checkpoint.hide()