extends Area2D

class_name PnC_ObjectGetter

@export var target_object: String
@export var picked_key: String
@export var hover_cursor: String
@export var input_priority: int = 0

var action = null

func _ready() -> void:
	var picked = false
	if picked_key != null:
		if not GameState.check(picked_key):
			GameState.keys[picked_key] = false
		picked = GameState.keys[picked_key]
	if picked:
		queue_free()
	else:
		connect("input_event", _process_input)
		connect("mouse_entered", _mouse_entered_update)
		connect("mouse_exited", _mouse_exited_update)

func _process_input(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if Cursor.is_left_click(event):
		if Cursor.area_has_focus(self):
			Global.world.objectManager.add_object(
				target_object
			)
			if action != null:
				action.call()
			if picked_key != null:
				GameState.mark(picked_key)
			queue_free()

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
