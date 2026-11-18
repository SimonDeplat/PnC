extends Node

var id = "PnC_Demo"

var lang = "fr"

var save_data = {
	"current_room" = "RoomA",
}

var rooms_folder = "res://Game/PnC_Demo/Rooms/"
var rooms = {
	"RoomA" : "RoomA/room_a.tscn",
	"RoomB" : "RoomB/room_b.tscn",
}

var cursors_sprites = {
	"interact" : preload("res://Game/PnC_Demo/Cursors/interact.png"),
	"inspect" : preload("res://Game/PnC_Demo/Cursors/inspect.png"),
	"move" : preload("res://Game/PnC_Demo/Cursors/move.png"),
	"talk" : preload("res://Game/PnC_Demo/Cursors/talk.png"),
}

var texts = {
	"speech" : {
		"eng" : "This is the engine demo !",
		"fr" : "C'est la démo du moteur !",
	},
	"painting" : {
		"eng" : "What a wonderful drawing !",
		"fr" : "Quel merveilleux dessin !",
	},
}

var objects_sprites = {}
var tracks = {}
var sounds = {}

func _ready() -> void:
	pass

func init():
	pass
