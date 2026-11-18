extends Control

func _ready() -> void:
	set_visible(false)
	$Menu/RoomsButton.set_pressed(true)
	$Menu/GameStateButton.set_pressed(false)

func init() -> void:
	_init_room_hacks()

func _init_room_hacks():
	var columns = int(sqrt(Global.rooms.size())) + 1
	$RoomHack/GridContainer.set_columns(columns)
	
	for key in Global.rooms:
		var b = Button.new()
		b.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		b.set_v_size_flags(Control.SIZE_EXPAND_FILL)
		b.set_text(key)
		b.connect(
			"button_down",
			func():
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
				set_visible(false)
				Global.world.load_room(key)
		)
		$RoomHack/GridContainer.add_child(b)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		set_visible(false)

func display() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_visible(true)

func _on_close_button_button_down() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_visible(false)
