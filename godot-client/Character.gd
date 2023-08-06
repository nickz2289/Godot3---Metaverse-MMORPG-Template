extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var arah = ""
var orang_lain = false
var speed = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(orang_lain == true):
		if str(arah) == 'left':
			translation -= Vector3(speed,0,0)*delta
		elif str(arah) == 'right':
			translation += Vector3(speed,0,0)*delta
		elif str(arah) == 'up':
			translation -= Vector3(0,0,speed)*delta
		elif  str(arah) == 'down':
			translation += Vector3(0,0,speed)*delta
