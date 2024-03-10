extends Node2D

signal sailOrientationSig(orientation)
signal WindPower(wind)

var windForceFromLevel
var windForceRatio
var windOrientationFromLevel
var sailOrientation
@export var sailLifeMax : float = 100.0
var sailLife : float
var sailRepair = 0
var windForceBeforeDamage = 10
var deployed : bool = true
var hoisting : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	windForceFromLevel = 0
	windOrientationFromLevel = 0
	sailOrientation = 0
	windForceBeforeDamage = 10
	sailLife = sailLifeMax

# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta):
	if Input.is_action_just_released("Hoist"):
		hoisting = false
	if Input.is_action_pressed("SteerSailLeft"):
		sailOrientation += PI * .15 * delta
		if sailOrientation >= PI:
			sailOrientation -= 2*PI
	if Input.is_action_pressed("SteerSailRight"):
		sailOrientation -= PI * 0.15 * delta
		if sailOrientation <= - PI:
			sailOrientation += 2* PI
	
	windForceRatio = 0.5 + cos(windOrientationFromLevel - sailOrientation)/2
	var wind = windForceRatio * windForceFromLevel
	
	if wind >= windForceBeforeDamage and deployed and sailLife > 0:
		sailLife -=1
		if sailLife < 0:
			$NormalSail.visible=false
			$DamagedSail.visible=true
			

	var text = "wind orientation "+ str(sailOrientation).substr(0,4) + "/" + str(windOrientationFromLevel) + "\n"
	text = text + "wind force" + str(wind) + "\n"
	text = text + "wind force Ratio" + str(windForceRatio) + "\n"
	$WindLabel.text = text
	
	sailOrientationSig.emit(sailOrientation)
	if deployed and sailLife > 0:
		WindPower.emit(wind)

func _on_deployed_input_event(_viewport, event, _shape_idx):
	if deployed and event.is_action_pressed("Hoist"):
		hoisting = true
	elif deployed == false and hoisting and event.is_action_released("Hoist"):
		hoisting = false
		deployed = true
		$NormalSail.scale.y *= 5
		$NormalSail.position.y += 325

func _on_undeployed_input_event(_viewport, event, _shape_idx):
	if deployed == false and event.is_action_pressed("Hoist") :
		hoisting = true
	elif deployed and hoisting and event.is_action_released("Hoist"):
		hoisting = false
		deployed = false
		$NormalSail.scale.y *= 0.2
		$NormalSail.position.y -= 325

func _on_mast_wind_changes_from_mast(windForce, windOrientation):
	windForceFromLevel = windForce
	windOrientationFromLevel = windOrientation

func _on_repair_input_event(viewport, event, shape_idx):
	if sailLife<1 and event.is_action_pressed("Fix"):
		sailRepair += 5
	if sailRepair > 99 :
		sailRepair = 0
		sailLife = sailLifeMax
		$NormalSail.visible=true
		$DamagedSail.visible=false
