extends Node2D

var world_scene = preload("res://PnC/Global/world.tscn")

func _ready() -> void:
	var game = $Game.game
	var world
	
	world = world_scene.instantiate()
	add_child(world)
	
	game = game.instantiate()
	add_child(game)
	
	Global.game = game
	if "lang" in game:
		Lang.lang = game.lang
	Global.rooms_folder = game.rooms_folder
	Global.rooms = game.rooms
	Lang.texts = game.texts
	Cursor.cursors_sprites = game.cursors_sprites
	Cursor.objects_sprites = game.objects_sprites
	Cursor.init()
	
	GameState.load_game(game)
	
	world.init()
	game.init()
	world.load_room(GameState.keys["current_room"])

func quit() -> void:
	GameState.save_game()
	get_tree().quit()
