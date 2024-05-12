extends Control

var address = "127.0.0.1"
var port = 8910
var max_players = 2
var peer

func start_game():
	var scene = load("res://Game.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func _on_host_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, max_players)
	if error != OK:
		print("Cannot host: " + error)
		return
	multiplayer.set_multiplayer_peer(peer)
	
	start_game()

func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	start_game()
