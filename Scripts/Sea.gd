extends StaticBody2D

var t:float = 0
var dt:float = 4.0
var Ship
var ship_position_x

var noise:FastNoiseLite = FastNoiseLite.new()

func _ready():
	noise.seed = randi()
	noise.fractal_octaves = 4
	Ship = get_parent().get_node('Ship')

func _process(delta):
	ship_position_x = Ship.global_position.x
	var vertices:Array = []
	# the first two are bottom right and bottom left vertices:
	vertices.append(Vector2(1000, 100))
	vertices.append(Vector2(-1000, 100))
	for i in range(-100, 101):
		# make a sum of sin to generate some sort of wave
		var y:float = 35 * sin(0.05 * i - 0.05 * t)
		y += 3 * sin(0.09 * i - 0.21 * t)
		y += 20 * sin(0.05 * i - 0.25 * t)
		# add some noise to make it look a bit random
		y += 5 * noise.get_noise_1d(5 * i - 0.5 * t);
		# the position have to match the width of the polygon
		# here 100 * 10 = 1000, see first two vertices above
		vertices.append(Vector2(i * 10, y))
	
	# update the polygons
	$DynamicWaves.global_position.x = ship_position_x -300
	$DynamicWaves.polygon = PackedVector2Array(vertices)
	$DynamicShape.global_position.x = ship_position_x - 300
	$DynamicShape.polygon = PackedVector2Array(vertices)
	print("ship_position_x = ",ship_position_x,"; DynamicWaves = ", $DynamicWaves.position.x,"; DynamicShape = ",$DynamicShape.position.x)
	

	t += dt * delta # make the waves move over time
