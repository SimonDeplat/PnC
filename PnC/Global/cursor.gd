extends Node

var type = "cursor"
var disabled = false

var cursors_sprites
var objects_sprites

var state = "interact"

var hovered_areas = []

var default_interact_cursor = preload("res://PnC/Assets/interact_cursor.png")
var default_disabled_cursor = preload("res://PnC/Assets/disable_cursor.png")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func init():
	if not cursors_sprites.has("interact"):
		cursors_sprites["interact"] = default_interact_cursor
	if not cursors_sprites.has("disabled"):
		cursors_sprites["disabled"] = default_disabled_cursor
	set_cursor()

func _input(event: InputEvent) -> void:
	if not disabled:
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.get_button_index() == 2:
					set_cursor()

func is_left_click(event: InputEvent) -> bool:
	var event_is_left_click = event is InputEventMouseButton
	if event_is_left_click:
		event_is_left_click = not disabled
	if event_is_left_click:
		event_is_left_click = event.is_pressed()
	if event_is_left_click:
		event_is_left_click = (event.get_button_index() == 1)
	return event_is_left_click

func area_has_focus(area: Area2D) -> bool:
	var has_focus = true
	for other_area in hovered_areas:
		if other_area.input_priority > area.input_priority:
			has_focus = false
	return has_focus

func update() -> void:
	if type == "cursor":
		if not disabled:
			var cursor_id = "interact"
			var priority = -1
			for area in hovered_areas:
				if area.input_priority > priority:
					if area.hover_cursor != "":
						priority = area.input_priority
						cursor_id = area.hover_cursor
			if Global.world != null:
				Global.world.set_object(cursors_sprites[cursor_id])

func set_cursor():
	type = "cursor"
	state = "interact"
	update()

func set_object(id: String):
	type = "object"
	state = id
	if Global.world != null:
		Global.world.set_object(objects_sprites[id])

func set_disabled(blocked: bool) -> void:
	disabled = blocked
	if disabled:
		if Global.world != null:
			Global.world.set_object(
				cursors_sprites["disabled"]
			)
	else:
		if type == "cursor":
			update()
		else:
			if Global.world != null:
				Global.world.set_object(
					objects_sprites[state]
				)
