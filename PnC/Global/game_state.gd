extends Node

# This node is global, and always loaded
# Use "GameState.keys["keyName"]" to access
# and modify the state of the game

var game_folder
var new_file

var save_on_mark = true

var do_reset_save_files = true

var keys

func check(key: String) -> bool:
	var is_true = false
	if keys.has(key):
		is_true = keys[key]
	else:
		keys[key] = false
	return is_true

func mark(key: String) -> void:
	keys[key] = true
	if save_on_mark:
		save_game()

func save_game() -> void:
	var file
	
	file = FileAccess.open(
		game_folder + "save.dat",
		FileAccess.WRITE
	)
	
	file.store_string(JSON.stringify(keys))

func _load_file() -> void:
	var file
	var json
	
	file = FileAccess.open(
		game_folder + "save.dat",
		FileAccess.READ
	)
	
	json = JSON.new()
	json.parse(file.get_as_text())
	keys = json.data

# Create mandatory keys if missing
func _check_new_file_keys() -> void:
	if not new_file.has("objects"):
		new_file["objects"] = []

func _check_user_folder():
	var file
	
	if not DirAccess.dir_exists_absolute(game_folder):
		DirAccess.make_dir_absolute(game_folder)
	
	_check_new_file_keys()
	
	if not FileAccess.file_exists(game_folder + "save.dat"):
		file = FileAccess.open(
			game_folder + "save.dat",
			FileAccess.WRITE
		)
		file.store_string(JSON.stringify(new_file))

func _reset_save_files() -> void:
	var file = FileAccess.open(
		game_folder + "save.dat",
		FileAccess.WRITE
	)
	
	_check_new_file_keys()
	
	file.store_string(JSON.stringify(new_file))

func load_game(game: Node) -> void:
	game_folder = "user://" + game.id + "/"
	new_file = game.save_data
	_check_user_folder()
	if do_reset_save_files:
		_reset_save_files()
	_load_file()
