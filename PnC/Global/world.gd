extends Node2D

@onready var textDisplay = $TextDisplay
@onready var uiLayer = $UILayer
@onready var cheats = $Cheats

var current_room
var current_room_ID
var last_room_ID = ""

var current_bg = ""

var cursor_pos

func _ready() -> void:
	Global.world = self
	Global.textDisplay = $TextDisplay

func _process(_delta: float) -> void:
	# Clip cursor pos
	cursor_pos = get_viewport().get_mouse_position()
	#_clip_cursor_pos()
	$Object.set_global_position(cursor_pos)

func _clip_cursor_pos() -> void:
	cursor_pos.x = max(
		cursor_pos.x,
		5 + ($Object.get_texture().get_width() / 2)
	)
	cursor_pos.x = min(
		cursor_pos.x,
		1920 - 5 - ($Object.get_texture().get_width() / 2)
	)
	cursor_pos.y = max(
		cursor_pos.y,
		5 + ($Object.get_texture().get_height() / 2)
	)
	cursor_pos.y = min(
		cursor_pos.y,
		1080 - 5 - ($Object.get_texture().get_height() / 2)
	)

func init() -> void:
	$Cheats.init()

func set_object(texture: Texture2D) -> void:
	$Object.set_texture(texture)

# Loads a new room when needed
func load_room(room_ID: String) -> void:
	var path
	if current_room != null:
		last_room_ID = current_room_ID
		current_room.queue_free()
	current_room_ID = room_ID
	path = "".join([Global.rooms_folder, Global.rooms[room_ID]])
	print(path)
	current_room = load(path).instantiate()
	$RoomContainer.add_child(current_room)
	$TextDisplay.clear_text()
	GameState.keys["current_room"] = room_ID

func clear_room() -> void:
	if current_room != null:
		current_room.queue_free()
		current_room = null
		current_room_ID = null

func clear_bg_layer() -> void:
	for child in $BGLayer.get_children():
		child.queue_free()
