extends Node2D

signal windFromSail(wind)
signal windOrientationSig(orientation)
signal sailOrientationSig(orientation)

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
	windOrientation = -0.3
	sailOrientation = 0.3
	windForceBeforeDamage = 10
	sailDeploy = 1
	sailLife = 100


# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta):
	if Input.is_action_pressed("SteerSailLeft"):
		sailOrientation += PI * .15 * delta
		if sailOrientation >= PI:
			sailOrientation -= 2*PI
	if Input.is_action_pressed("SteerSailRight"):
		sailOrientation -= PI * 0.15 * delta
		if sailOrientation <= - PI:
			sailOrientation += 2* PI
	
	if Input.is_action_pressed("DeploySail"):
		sailDeploy -= 0.2 * delta
		if sailDeploy < 0 :
			sailDeploy = 0
	if Input.is_action_pressed("PullSail"):
		sailDeploy += 0.2 * delta
		if sailDeploy > 1:
			sailDeploy = 1
	
	windForceRatio = 0.5 + cos(windOrientation - sailOrientation)/2
	var wind = windForceRatio * windForceFromLevel * sailDeploy
	
	if wind >= windForceBeforeDamage:
		sailLife -=0.01 * delta
	windFromSail.emit(wind)
	var text = "wind orientation "+ str(sailOrientation).substr(0,4) + "/" + str(windOrientation) + "\n"
	text = text + "sail deploy" + str(sailDeploy) + "\n"
	text = text + "wind force" + str(wind) + "\n"
	text = text + "wind force Ratio" + str(windForceRatio) + "\n"
	$WindLabel.text = text
	
	windOrientationSig.emit(windOrientation)
	sailOrientationSig.emit(sailOrientation)
