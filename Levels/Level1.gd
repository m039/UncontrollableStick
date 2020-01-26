extends BaseLevel

const BallClass = preload("res://Objects/Ball.gd")

var ball
var ballActive : bool
var ballActiveCheckpoints : int = 0
var checkpoints = []
var stickActiveZones = []
var stickNormalZone
var initialized : bool = false
var finished : bool = false
var bigMessage 
var winScreen
var finishedTime : float

func _ready():
	$Stick.set_visibility(false)
	$Stick.set_input_enabled(false)

	# Create welcome messages
	
	bigMessage = show_big_message()

	bigMessage.text = "Ready"

	yield(get_tree().create_timer(2), "timeout")

	bigMessage.text = "Collect\nBlue\nSquares"

	yield(get_tree().create_timer(2), "timeout")

	bigMessage.queue_free()

	# Initialization

	stickActiveZones.append(get_node("Stick/Zones/ActiveZone1"))
	stickActiveZones.append(get_node("Stick/Zones/ActiveZone2"))
	stickNormalZone = get_node("Stick/Zones/NormalZone")

	# Create a ball and start the game
	
	start_game()

	initialized = true

func _physics_process(delta):
	if !initialized:
		return

	# Set the ball's activie state.

	if ball.get_area().overlaps_area(stickNormalZone):
		ballActive = false
	else:
		for zone in stickActiveZones:
			if ball.get_area().overlaps_area(zone):
				ballActive = true
				break

	ball.set_active(ballActive)

func _on_restart():
	# If the player has collected all squares, don't restart the game
	if !finished:
		start_game()

func start_game():
	# Create or reset the ball.
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
	
	# Reset stick.
	$Stick.set_visibility(true)
	$Stick.set_input_enabled(true)

func _on_checkpoint_entered(ball, checkpoint):
	if ball is BallClass:
		_on_ball_entered(ball, checkpoint)

# A callback function when the ball entered a square.
func _on_ball_entered(ball, checkpoint):
	set_checkpoint_enabled(checkpoint, false)

	if ballActive:
		ballActiveCheckpoints += 1

	if checkpoints.size() == 1:
		# Show win screen.

		winScreen = show_win_screen()
		winScreen.set_number_of_stars(ballActiveCheckpoints + 1);

		# Hide the stick
		$Stick.set_visibility(false)
		$Stick.set_input_enabled(false)

		finished = true;
	else:	
		checkpoints.erase(checkpoint)
		set_checkpoint_enabled(checkpoints[0], true)

func set_checkpoint_enabled(checkpoint, value):
	checkpoint.set_collision_enabled(value)
	if (value):
		checkpoint.show()
	else:
		checkpoint.hide()