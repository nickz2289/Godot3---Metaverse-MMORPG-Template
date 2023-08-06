extends CSGBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 0.1;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		translation -= Vector3(speed,0,0)
	if(Input.is_action_pressed("ui_right")):
		translation += Vector3(speed,0,0)
	if(Input.is_action_pressed("ui_up")):
		translation -= Vector3(0,0,speed)
	if(Input.is_action_pressed("ui_down")):
		translation += Vector3(0,0,speed)
