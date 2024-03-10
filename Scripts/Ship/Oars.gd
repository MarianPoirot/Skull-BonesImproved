extends Node2D

var z = true
var d = false
var s = false
var q = false
var tween
var paddle_ready = true

signal paddle_acceleration

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if paddle_ready :
		if z and Input.is_action_just_pressed("qte z"):
			z = false
			d = true
			tween = $RotationNode.create_tween()
			tween.tween_property($RotationNode, "rotation_degrees", 90, 0.1).as_relative()
			$Timer.start()
			paddle_ready = false
		elif d and Input.is_action_just_pressed("qte d"):
			d = false
			s = true
			tween = $RotationNode.create_tween()
			tween.tween_property($RotationNode, "rotation_degrees", 90, 0.1).as_relative()
			$Timer.start()
			paddle_ready = false
		elif s and Input.is_action_just_pressed("qte s"):
			s = false
			q = true
			tween = $RotationNode.create_tween()
			tween.tween_property($RotationNode, "rotation_degrees", 90, 0.1).as_relative()
			emit_signal("paddle_acceleration")
			$Timer.start()
			paddle_ready = false
		elif q and Input.is_action_just_pressed("qte q"):
			q = false
			z = true
			tween = $RotationNode.create_tween()
			tween.tween_property($RotationNode, "rotation_degrees", 90, 0.1).as_relative()
			emit_signal("paddle_acceleration")
			$Timer.start()
			paddle_ready = false

func _on_timer_timeout():
	paddle_ready = true
