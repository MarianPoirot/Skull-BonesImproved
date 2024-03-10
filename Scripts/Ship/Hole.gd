extends Node2D

var hole = true
var holeRepair = 0

signal holeSink()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hole :
		emit_signal("holeSink")

func _on_area_to_fix_input_event(_viewport, event, _shape_idx):
	if hole and event.is_action_pressed("Fix"):
		holeRepair += 34
	if holeRepair > 99 :
		holeRepair = 0
		hole=false
		$SpriteHole.visible=false

func create_hole():
	hole = true
	$SpriteHole.visible=true
