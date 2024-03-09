extends RigidBody2D

var currentBoatSpeed = 5
var currentRotationSpeed = 2
var maxBoatSpeed = 5
var maxRotationSpeed = 2
var maxWaterLevel = 200
var currentWaterLevel = 0

var canMove = true

# Called when the node enters the scene tree for the first time.
func _ready():
	currentRotationSpeed = maxRotationSpeed
	currentBoatSpeed = maxBoatSpeed
	currentWaterLevel = maxWaterLevel
	canMove = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("SteerLeft"):
		angular_velocity += delta * currentRotationSpeed
	if Input.is_action_pressed("SteerRight"):
		angular_velocity -= delta * currentRotationSpeed
	if Input.is_action_pressed("Sink"):
		AddWater(1)
	if Input.is_action_pressed("Boost"):
		AddSpeed(1)
	if not canMove:
		linear_velocity.x = 0



func AddWater(amount):
	currentWaterLevel += amount
	if(currentWaterLevel >= maxWaterLevel):
		_OnLose()

func AddSpeed(amount):
	if(canMove):
		linear_velocity.x += amount * currentBoatSpeed

func _OnLose():
	if get_tree().change_scene_to_file("res://Scenes/UI/Ending.tscn") != OK:
		print ("Error passing from Opening scene to main scene")


func _on_anchor_notouch():
	canMove = true
	


func _on_anchor_touchdown():
	canMove = false


func _on_mast_wind_from_mast(wind):
	AddSpeed(wind)
