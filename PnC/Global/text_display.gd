extends Node2D

signal dialog_closed

@onready var drawingLayer = $DrawingLayer

var default_textbox = preload("res://PnC/Assets/textBox.png")

var isWaiting = false
var isPlaying = false
var time = 0

var shutter_modulate = 0.5

func _ready() -> void:
	set_process(false)
	$GlobalMouseControl.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	$Shutter.set_modulate(Color(0, 0, 0, 0))
	$TextBox.set_modulate(Color(1, 1, 1, 1))
	$TextBox/Area2D.set_pickable(false)
	reset_textbox()

func _process(delta: float) -> void:
	time = time - delta
	if time <= 0:
		$TextBox/Anim.play("fadeOut")
		$TextBox/Area2D.set_pickable(false)
		set_process(false)
		isPlaying = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		if isWaiting:
			_stop_waiting()

func play_text(text: String, textTime: float) -> void:
	var tr_text = Lang.get_text(text)
	$TextBox/Label.set_text(tr_text)
	time = textTime
	
	if textTime > 0:
		if not isWaiting:
			if not isPlaying:
				isPlaying = true
				$TextBox/Anim.play("fadeIn")
				$TextBox/Area2D.set_pickable(true)
				set_process(true)
	else:
		isWaiting = true
		
		if isPlaying:
			set_process(false)
			$TextBox/Anim.stop()
			isPlaying = false
		$Shutter.set_modulate(Color(0, 0, 0, shutter_modulate))
		$TextBox.set_modulate(Color(1, 1, 1, 1))
		$GlobalMouseControl.set_mouse_filter(Control.MOUSE_FILTER_STOP)

func clear_text() -> void:
	set_process(false)
	$TextBox/Anim.stop()
	$TextBox.set_modulate(Color(1, 1, 1, 0))
	$TextBox/Area2D.set_pickable(false)
	isPlaying = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Cursor.is_left_click(event):
		clear_text()

func set_textbox(textbox: Texture2D) -> void:
	$TextBox/Sprite2D.set_texture(textbox)
	$TextBox/Area2D/CollisionShape2D.get_shape().set_size(
		textbox.get_size()
	)
	
	$TextBox/Label.set_position(
		textbox.get_size() * Vector2(0.9, 0.9) * Vector2(-0.5, -0.5)
	)
	$TextBox/Label.set_size(
		textbox.get_size() * Vector2(0.9, 0.9)
	)

func set_textbox_position(pos: Vector2) -> void:
	$TextBox.set_position(pos)

func set_default_textbox(texture: Texture2D) -> void:
	default_textbox = texture
	set_textbox(default_textbox)

func reset_textbox() -> void:
	set_textbox(default_textbox)

func clear_drawing_layer() -> void:
	for child in $DrawingLayer.get_children():
		child.queue_free()

func _on_global_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Global.is_left_click(event):
		if isWaiting:
			_stop_waiting()

func _stop_waiting() -> void:
	$Shutter.set_modulate(Color(0, 0, 0, 0))
	$TextBox.set_modulate(Color(1, 1, 1, 0))
	$GlobalMouseControl.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	isWaiting = false
	dialog_closed.emit()

func _on_global_mouse_control_gui_input(event: InputEvent) -> void:
	if Cursor.is_left_click(event):
		if isWaiting:
			# Consume the event so it is not propagated
			$GlobalMouseControl.accept_event()
			_stop_waiting()
