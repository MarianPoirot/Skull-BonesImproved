extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func lightning():
	$AudioStreamPlayer2D.play()
	$PointLight2D.energy = 1
	$TimerLight.start()


func _on_timer_light_timeout():
	$PointLight2D.energy = 0


func _on_timer_between_lightning_timeout():
	lightning()
