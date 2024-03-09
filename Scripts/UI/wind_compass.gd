extends Node2D

var windArrow
var windOrientationGoal
var currentWindOrientation

var sailOrientationGoal
var currentSailOrientation
var sailArrow

# Called when the node enters the scene tree for the first time.
func _ready():
	
	currentWindOrientation = -0.5
	windOrientationGoal = 0
	sailOrientationGoal = 1
	currentSailOrientation = 0.5
	windArrow = $WindArrow.create_tween()
	sailArrow = $SailArrow.create_tween()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	windArrow = $WindArrow.create_tween()
	sailArrow = $SailArrow.create_tween()
	windArrow.tween_property($WindArrow, "rotation", windOrientationGoal, delta)
	sailArrow.tween_property($SailArrow, "rotation", sailOrientationGoal, delta)

func _on_ship_sail_orientation_from_ship(orientation):
	windOrientationGoal = orientation


func _on_ship_wind_orientation_from_ship(orientation):
	sailOrientationGoal = orientation
