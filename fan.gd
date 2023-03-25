extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var speed = 1
func _process(delta):
	rotation.y += rotation.y + speed*delta
	if rotation.y > 360:
		rotation.y = 0
