extends Node2D

signal windChangesFromMast(windForce, windOrientation)
signal sailOrientationFromMast(orientation)
signal windPowerFromMast(wind)

@export var broken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ship_wind_changes_from_ship(windForce, windOrientation):
		windChangesFromMast.emit(windForce, windOrientation)

func _on_sail_sail_orientation_sig(orientation):
	sailOrientationFromMast.emit(orientation)

func _on_sail_wind_power(wind):
	if not broken:
		windPowerFromMast.emit(wind)
