extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5

var arah = ''
var bolehpencet = true
var lepaspencet = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if(Input.is_action_pressed("ui_left") && bolehpencet == true):
		arah = 'left'
	elif(Input.is_action_pressed("ui_right") && bolehpencet == true):
		arah = 'right'
	elif(Input.is_action_pressed("ui_up") && bolehpencet == true):
		arah = 'up'
	elif(Input.is_action_pressed("ui_down") && bolehpencet == true):
		arah = 'down'
		
		
	if(Input.is_action_just_released("ui_left")):
		arah = ""
		bolehpencet = true
	elif(Input.is_action_just_released("ui_right")):
		arah = ""
		bolehpencet = true
	elif(Input.is_action_just_released("ui_up")):
		arah = ""
		bolehpencet = true
	elif(Input.is_action_just_released("ui_down")):
		arah = ""
		bolehpencet = true
		
	if arah == 'left':
			translation -= Vector3(speed,0,0)*delta
			if bolehpencet== true:
				$".."._onPlayerMove('left', translation)
			bolehpencet = false
			lepaspencet = false
	elif arah == 'right':
			translation += Vector3(speed,0,0)*delta
			if bolehpencet== true:
				$".."._onPlayerMove('right', translation)
			bolehpencet = false
			lepaspencet = false
	elif arah == 'up':
			translation -= Vector3(0,0,speed)*delta
			if bolehpencet== true:
				$".."._onPlayerMove('up', translation)
			bolehpencet = false
			lepaspencet = false
	elif arah == 'down':
			translation += Vector3(0,0,speed)*delta
			if bolehpencet== true:
				$".."._onPlayerMove('down', translation)
			bolehpencet = false
			lepaspencet = false
	else:
		if lepaspencet == false && bolehpencet== true:
			$".."._onPlayerMove('', translation)
		lepaspencet = true
