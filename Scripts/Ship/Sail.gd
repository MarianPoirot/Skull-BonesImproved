extends Node2D

signal windFromSail(wind)

var windForceFromLevel
var windForceRatio
var windOrientation
var sailOrientation

# Called when the node enters the scene tree for the first time.
func _ready():
	windForceFromLevel = 0.5
	windOrientation = -1
	sailOrientation = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta):
	windForceRatio = 1.1 + sin(windOrientation - sailOrientation)
	var wind = windForceRatio * windForceFromLevel
	windFromSail.emit(wind)
