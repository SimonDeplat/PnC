extends Area2D

class_name PnC_Interaction

@export var disabled_key: String
@export var hover_cursor: String
@export var input_priority: int = 0

var texts = {}
var functions = {}
var default_text
var default_time

func _ready() -> void:
	if disabled_key != "":
		if not GameState.check(disabled_key):
			GameState.keys[disabled_key] = false
		if GameState.check(disabled_key):
			queue_free()
	
	connect("input_event", _process_input)
	connect("mouse_entered", _mouse_entered_update)
	connect("mouse_exited", _mouse_exited_update)

func _process_input(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	var state
	if Cursor.is_left_click(event):
		if Cursor.area_has_focus(self):
			state = Cursor.state
			if Cursor.type == "interact":
				state = "interact"
			if texts.has(state):
				Global.play_text(
					texts[state]["text"],
					texts[state]["time"]
				)
			else:
				if not functions.has(state):
					if default_text != null:
						Global.play_text(
							default_text,
							default_time
						)
			
			if functions.has(state):
				functions[state].call()

func add_text(cursorState: String, text_id: String, time: float) -> void:
	texts[cursorState] = {
		"text" = text_id,
		"time" = time
	}

func add_default_text(text: String, time: int) -> void:
	default_text = text
	default_time = time

func add_function(cursorState: String, function: Callable) -> void:
	functions[cursorState] = function

func _mouse_entered_update() -> void:
	if not Cursor.hovered_areas.has(self):
		Cursor.hovered_areas.append(self)
		if hover_cursor != "":
			Cursor.update()

func _mouse_exited_update() -> void:
	if Cursor.hovered_areas.has(self):
		Cursor.hovered_areas.erase(self)
		if hover_cursor != "":
			Cursor.update()

func _exit_tree():
	if Cursor.hovered_areas.has(self):
		Cursor.hovered_areas.erase(self)
		if hover_cursor != "":
			Cursor.update()
