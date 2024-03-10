extends Node2D


@export var ExplodingObstacle : PackedScene
var michel : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	michel = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hitbox_body_entered(body):
	if michel:
		remove_child(get_node("CollisionShape2D"))
		remove_child(get_node("ObstacleSprite"))
		remove_child(get_node("hitbox"))
		add_child(ExplodingObstacle.instantiate())
		michel = false
		get_parent().CollisionWithShip()
