extends Area2D

class_name PnC_RoomWay

@export var target_room: String
@export var hover_cursor: String
@export var input_priority: int = 0

var action = null

func _ready() -> void:
	connect("input_event", _process_input)
	connect("mouse_entered", _mouse_entered_update)
	connect("mouse_exited", _mouse_exited_update)

func _process_input(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if Cursor.is_left_click(event):
		if Cursor.area_has_focus(self):
			if action != null:
				action.call()
			Global.world.load_room(
				target_room
			)

func set_action(callable: Callable) -> void:
	action = callable

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
