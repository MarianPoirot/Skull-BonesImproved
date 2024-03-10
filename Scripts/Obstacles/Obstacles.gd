extends Node2D

@export var Obstacle : PackedScene
signal CollisionWithObstacle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func CollisionWithShip():
	CollisionWithObstacle.emit()


func _on_timer_timeout():
	add_child(Obstacle.instantiate())
	$Timer.wait_time = randf_range(3.,10.)
	
