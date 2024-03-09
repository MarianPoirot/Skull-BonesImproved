extends Node2D

signal windFromSail(wind)

var windForceFromLevel
var windForceRatio
var windOrientation
var sailOrientation

# Called when the node enters the scene tree for the first time.
func _ready():
	windForceFromLevel = 3
	windOrientation = -1
	sailOrientation = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta):
	if Input.is_action_pressed("SteerSailLeft"):
		sailOrientation = sailOrientation - 0.05
		if sailOrientation >= 1:
			sailOrientation -= 2
	if Input.is_action_pressed("SteerSailRight"):
		sailOrientation += 0.05
		if sailOrientation <= -1:
			sailOrientation += 2
	windForceRatio = 1.1 + sin(windOrientation - sailOrientation)
	var wind = windForceRatio * windForceFromLevel
	windFromSail.emit(wind)
