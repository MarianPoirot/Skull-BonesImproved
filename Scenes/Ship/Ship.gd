extends RigidBody2D

var boatSpeed = 100
var rotationSpeed = 10
var maxWaterLevel = 200
var currentWaterLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("SteerLeft"):
		angular_velocity += delta * rotationSpeed
	if Input.is_action_pressed("SteerRight"):
		angular_velocity -= delta * rotationSpeed
	if Input.is_action_pressed("Sink"):
		AddWater(1)

func AddWater(amount):
	currentWaterLevel += amount
	if(currentWaterLevel >= maxWaterLevel):
		_OnLose()

func _OnLose():
	if get_tree().change_scene_to_file("res://Scenes/UI/Ending.tscn") != OK:
		print ("Error passing from Opening scene to main scene")
