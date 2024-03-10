extends Node2D

func lightning():
	$AudioStreamPlayer2D.play()
	$PointLight2D.energy = 1
	$TimerLight.start()


func _on_timer_light_timeout():
	$PointLight2D.energy = 0


func _on_timer_between_lightning_timeout():
	lightning()
