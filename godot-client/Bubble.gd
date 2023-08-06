extends Sprite3D


var show = false
var timer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if show == true:
		visible = true
	else:
		visible = false
		
		

func _timerStart():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_timeout")
	timer.wait_time = 3
	show = true
	timer.start()
	
func _timeout():
	show = false
