extends Node2D

@export var windOrientationGoal = 0
@export var currentWindOrientation = -0.5
@export var sailOrientationGoal = 1
@export var currentSailOrientation = 0.5
var sailArrow
var windArrow

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	windArrow = $WindArrow.create_tween()
	sailArrow = $SailArrow.create_tween()
	windArrow.tween_property($WindArrow, "rotation", windOrientationGoal, delta)
	sailArrow.tween_property($SailArrow, "rotation", sailOrientationGoal, delta)

func _on_main_wind_changes(_windForce, windOrientation):
	windOrientationGoal = windOrientation

func _on_ship_sail_orientation_from_ship(orientation):
	sailOrientationGoal = orientation
