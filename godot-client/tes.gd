extends Spatial

var websocket_url = "ws://127.0.0.1:3000"
var _client = WebSocketClient.new()

var username = ""
var speed = 0.1

func _ready():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url, ["lws-mirror-protocol"])
	if err != OK:
		print("Unable to connect")
		set_process(false)
	
func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	_client.get_peer(1).put_packet(JSON.print({"type":"dc","username": username}).to_utf8())
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	_client.get_peer(1).put_packet(JSON.print({"test godot": "Test aja broo"}).to_utf8())

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var data = JSON.parse(_client.get_peer(1).get_packet().get_string_from_utf8()).result
	print("Got data from server: ", data)
	
	if(data['type'] == 'userDetail'):
		username = str(data['value'])
		$MainCharacter.translation = Vector3(data['position_x'], data['position_y'], data['position_z'])
		$MainCharacter/CharacterName/Viewport/Label.text = str(data['value'])
		
	
	if(data['type'] == 'addplayer'):
		for item in data['usernames']:
			var jsonxdata = data['usernames']
			if(!str(jsonxdata[item].username) == username):
				var chr = load("res://Character.tscn").instance()
				add_child(chr)
				chr.name = str(jsonxdata[item].username)
				get_node(str(jsonxdata[item].username)).orang_lain = true
				get_node(str(jsonxdata[item].username)).translation = Vector3(jsonxdata[item].position_x, jsonxdata[item].position_y, jsonxdata[item].position_z)
				get_node(str(jsonxdata[item].username)+'/CharacterName/Viewport/Label').text = str(jsonxdata[item].username)
				print("+player" + str(jsonxdata[item].username))
	
	if(data['type'] == 'pesan'):
		print(data)
		$RichTextLabel.text += str(data['username'])+": " + str(data['value']) +"\n"
		if(str(data['username']) == username):
			$MainCharacter/ChatBubble/Viewport/Label.text = str(data['value'])
			$MainCharacter/ChatBubble._timerStart()
		else:
			get_node(str(data['username']) + "/ChatBubble/Viewport/Label").text = str(data['value'])
			get_node(str(data['username']) + "/ChatBubble")._timerStart()
		$TextEdit.text = ""
		
	if(data['type']) == 'player_move':
		if(data['username'] == username):
			print("player:" + str(data['value']))
		else:
			if str(data['value']) == 'left':
				get_node(str(data['username'])).arah = 'left'
				get_node(str(data['username'])).translation = Vector3(data['position_x'], data['position_y'], data['position_z'])
			elif str(data['value']) == 'right':
				get_node(str(data['username'])).arah = 'right'
				get_node(str(data['username'])).translation = Vector3(data['position_x'], data['position_y'], data['position_z'])
			elif str(data['value']) == 'up':
				get_node(str(data['username'])).arah = 'up'
				get_node(str(data['username'])).translation = Vector3(data['position_x'], data['position_y'], data['position_z'])
			elif str(data['value']) == 'down':
				get_node(str(data['username'])).arah = 'down'
				get_node(str(data['username'])).translation = Vector3(data['position_x'], data['position_y'], data['position_z'])
			else:
				get_node(str(data['username'])).arah = ''
				get_node(str(data['username'])).translation = Vector3(data['position_x'], data['position_y'], data['position_z'])
			print("oranglain: " + str(data['username']) + ' arah ' + str(data['value']))
			
	if(data['type']) == 'player_come':
		if(str(data['username']) == username):
			print("player kita")
		else:
			var chr = load("res://Character.tscn").instance()
			add_child(chr)
			chr.name = str(data['username'])
			get_node(str(data['username'])).orang_lain = true
			get_node(str(data['username'])).translation = Vector3(data['position_x'], data['position_y'], data['position_z'])
			get_node(str(data['username'])+'/CharacterName/Viewport/Label').text = str(data['username'])
			print("masuk player" + str(data['username']))
			
	if(data['type'] == 'player_close'):
		get_node(str(data['username'])).queue_free()
		

func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()
	




func _on_Button_pressed():
	 # Replace with function body.
	var textisi = $TextEdit.text
	_client.get_peer(1).put_packet(JSON.print({"type":"pesan","username": username, "value": str(textisi)}).to_utf8())
	
func _onPlayerMove(arah, position):
	_client.get_peer(1).put_packet(JSON.print({"type":"player_move","username": username, "value": arah, "position_x": position.x, "position_y": position.y, "position_z": position.z}).to_utf8())
	
