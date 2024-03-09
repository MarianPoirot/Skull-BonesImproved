extends Node2D

signal sailOrientationSig(orientation)
signal WindPower(wind)

var windForceFromLevel
var windForceRatio
var windOrientationFromLevel
var sailOrientation
var sailDeploy
var sailLife
var windForceBeforeDamage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	windForceFromLevel = 0
	windOrientationFromLevel = 0
	sailOrientation = 0
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
	
	windForceRatio = 0.5 + cos(windOrientationFromLevel - sailOrientation)/2
	var wind = windForceRatio * windForceFromLevel * sailDeploy
	
	if wind >= windForceBeforeDamage:
		sailLife -=0.01 * delta
	var text = "wind orientation "+ str(sailOrientation).substr(0,4) + "/" + str(windOrientationFromLevel) + "\n"
	text = text + "sail deploy" + str(sailDeploy) + "\n"
	text = text + "wind force" + str(wind) + "\n"
	text = text + "wind force Ratio" + str(windForceRatio) + "\n"
	$WindLabel.text = text
	
	sailOrientationSig.emit(sailOrientation)
	WindPower.emit(wind)




func _on_mast_wind_changes_from_mast(windForce, windOrientation):
	windForceFromLevel = windForce
	windOrientationFromLevel = windOrientation
