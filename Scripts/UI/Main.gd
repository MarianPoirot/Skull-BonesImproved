extends Node2D
signal WindChanges(windForce, windOrientation)

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_timer_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_timer_timeout():
	WindChanges.emit(randf_range(0.5,2),randf_range(-PI,PI))
	
