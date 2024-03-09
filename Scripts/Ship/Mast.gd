extends Node2D

signal windFromMast(wind)
signal windOrientationFromMast(orientation)
signal sailOrientationFromMast(orientation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_sail_wind_from_sail(wind):
	emit_signal("windFromMast",wind)


func _on_sail_wind_orientation_sig(orientation):
	sailOrientationFromMast.emit(orientation)

func _on_sail_sail_orientation_sig(orientation):
	windOrientationFromMast.emit(orientation)
