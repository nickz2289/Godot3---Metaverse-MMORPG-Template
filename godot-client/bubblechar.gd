extends Spatial


var show = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var TimerTotal = 5
var TimerStart = 0
var _starttimer = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if show == true:
		visible = true
	else:
		visible = false
		
	if _starttimer == true && TimerStart<TimerTotal:
		TimerStart +=1 * delta
		show = true
	else:
		TimerStart = 0
		show = false
		_starttimer = false

func _timerStart():
	TimerStart = 0
	_starttimer = true
