extends Node2D

var z = true
var d = false
var s = false
var q = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if z and Input.is_action_just_pressed("qte z"):
		z = false
		d = true
		$RotationNode.rotation_degrees = 90
	elif d and Input.is_action_just_pressed("qte d"):
		d = false
		s = true
		$RotationNode.rotation_degrees = 180
	elif s and Input.is_action_just_pressed("qte s"):
		s = false
		q = true
		$RotationNode.rotation_degrees = 270
	elif q and Input.is_action_just_pressed("qte q"):
		q = false
		z = true
		$RotationNode.rotation_degrees = 0
