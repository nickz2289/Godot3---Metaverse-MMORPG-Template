extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var standar = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	#rect_position = Vector2(31,456)
	rect_size = Vector2(419, 58)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_tooglechatbtn_pressed():
	if(standar == true):
		rect_position.y += 200
		rect_size = Vector2(419, 58)
		standar = false
	else:
		rect_position.y -= 200
		rect_size = Vector2(419, 260)
		standar = true
