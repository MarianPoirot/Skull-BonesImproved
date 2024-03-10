extends RigidBody2D

signal sailOrientationFromShip(orientation)
signal windChangesFromShip(windForce, windOrientation)

var maxBoatSpeed = 3000
var currentBoatSpeedRatio = 1
var currentRotationSpeed = 2
var maxRotationSpeed = 1

var maxWaterLevel = 100
var currentWaterLevel = 0

var canMove = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var sb = StyleBoxFlat.new()
	$ProgressBar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("253a5e")
	currentRotationSpeed = 0
	currentBoatSpeedRatio = 1
	currentWaterLevel = 0
	canMove = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.rotation_degrees<-24 or self.rotation_degrees>24:
		AddWater(0.2)
	if Input.is_action_pressed("SteerLeft") and self.rotation_degrees<50:
		angular_velocity = +maxRotationSpeed
	elif Input.is_action_pressed("SteerRight") and self.rotation_degrees>-50:
		angular_velocity = -maxRotationSpeed
	else:
		angular_velocity = 0
	if Input.is_action_pressed("Boost"):
		AddSpeed(1)
	if not canMove:
		linear_velocity.x = 0

func AddWater(amount):
	currentWaterLevel += amount
	$ProgressBar.value+=amount
	if(currentWaterLevel >= maxWaterLevel):
		_OnLose()

func AddSpeed(amount):
	if(canMove):
		linear_velocity.x += limitSpeed(amount * currentBoatSpeedRatio)

func _OnLose():
	if get_tree().change_scene_to_file("res://Scenes/UI/Ending.tscn") != OK:
		print ("Error passing from Opening scene to main scene")

func _on_anchor_notouch():
	canMove = true

func _on_anchor_touchdown():
	canMove = false

func _on_mast_wind_from_mast(wind):
	AddSpeed(wind)

func limitSpeed(addedSpeed):
	addedSpeed *= cos((addedSpeed + linear_velocity.x ) / (maxBoatSpeed /2.))
	return addedSpeed

func _on_area_2d_body_exited(_body):
	$LightningStrike/AudioLightningStrike.play()
	$LightningStrike/SpriteLightningStrike.visible = true
	$LightningStrike/StrikeDuration.start()
	var tween = $Mast.create_tween()
	tween.tween_property($Mast, "rotation_degrees", 75, 5)
	$"Mast/mast1-rope".set_deferred("visible",false)
	$"Mast/mast2-rope".set_deferred("visible",false)
	$LightningStrike/PointLight2D.energy = 1
	$Mast.broken = true

func _on_mast_sail_orientation_from_mast(orientation):
	sailOrientationFromShip.emit(orientation)

func _on_main_wind_changes(windForce, windOrientation):
	windChangesFromShip.emit(windForce, windOrientation)

func _on_mast_wind_power_from_mast(wind):
	AddSpeed(wind)

func _on_oars_paddle_acceleration():
	AddSpeed(1000)

func _on_strike_duration_timeout():
	$LightningStrike/SpriteLightningStrike.visible = false
	$LightningStrike/PointLight2D.energy = 0

func _on_hole_hole_sink():
	AddWater(0.1)


func _on_obstacles_collision_with_obstacle():
	$Hole.create_hole()
