extends Node3D

var interval = 0.1
var min_position = Vector3(-1000, -1000, -1000)
var max_position = Vector3(1000, 1000, 1000)

# Create a timer
var timer = Timer.new()

# Create a random number generator
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add the timer to the scene
	timer.set_wait_time(interval)
	timer.set_autostart(true)
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	var fan = get_node("Fan")
	# Create an instance of the .obj file
	var obj_instance = fan.duplicate()

	# Set a random position
	var random_position = Vector3(
		rng.randf_range(min_position.x, max_position.x),
		rng.randf_range(min_position.y, max_position.y),
		rng.randf_range(min_position.z, max_position.z)
	)

	obj_instance.transform.origin = random_position
	obj_instance.rotate(Vector3(0, 1, 0), rng.randf_range(0, 5))

	# Add the instance to the scene
	add_child(obj_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var mouse_sens = 0.3
var camera_anglev=0

func _input(event):
	var camera = get_node("Camera3D")
	if event is InputEventMouseMotion:
		camera.rotate_y(deg_to_rad(-event.relative.y*mouse_sens))
		var changev = -event.relative.y*mouse_sens
		if camera_anglev+changev > -50 and camera_anglev + changev < 50:
			camera_anglev+=changev
			camera.rotate_x(deg_to_rad(changev))
