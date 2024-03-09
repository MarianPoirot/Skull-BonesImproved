extends Node2D

signal touchdown
signal notouch

var move : float
var touch : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move=0.0
	if $AnchorSprite.position.y > 500 and touch==false:
		touch = true
		emit_signal("touchdown")
	elif touch==false:
		move = 0.5
		if Input.is_action_just_released("scroll_down"):
			move = 6
	if Input.is_action_just_released("scroll_up") and ($AnchorSprite.position.y-5>0):
		move = -5
		if touch==true:
			touch=false
			emit_signal("no touch")
	$AnchorSprite.position.y+=move
	$Line2D.set_point_position ( 1, $AnchorSprite.position )
