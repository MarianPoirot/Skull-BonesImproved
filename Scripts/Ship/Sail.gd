extends Node2D

signal windFromSail(wind)

var windForceFromLevel
var windForceRatio
var windOrientation
var sailOrientation
var sailDeploy
var sailLife
var windForceBeforeDamage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	windForceFromLevel = 3
	windOrientation = -1
	sailOrientation = 1
	windForceBeforeDamage = 10
	sailDeploy = 1
	sailLife = 100


# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta):
	if Input.is_action_pressed("SteerSailLeft"):
		sailOrientation -= 0.05 * delta
		if sailOrientation >= 1:
			sailOrientation -= 2
	if Input.is_action_pressed("SteerSailRight"):
		sailOrientation += 0.05 * delta
		if sailOrientation <= -1:
			sailOrientation += 2
	
	if Input.is_action_pressed("DeploySail"):
		sailDeploy -= 0.2 * delta
		if sailOrientation < 0 :
			sailDeploy = 0
	if Input.is_action_pressed("PullSail"):
		sailDeploy += 0.05 * delta
		if sailDeploy > 1:
			sailDeploy = 1
	
	windForceRatio = 1.1 + sin(windOrientation - sailOrientation)
	var wind = windForceRatio * windForceFromLevel * sailDeploy
	
	if wind >= windForceBeforeDamage:
		sailLife -=0.01 * delta
	
	windFromSail.emit(wind)
