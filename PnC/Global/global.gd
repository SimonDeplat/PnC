extends Node

# This node is global, i.e. always loaded

var world
var textDisplay
var objectManager

var game

var rooms_folder
var rooms

func play_text(text: String, time: float) -> void:
	if world != null:
		world.textDisplay.play_text(text, time)

func anim_to_end(anim: AnimationPlayer, id: String) -> void:
	anim.set_current_animation(id)
	anim.seek(
		anim.get_current_animation_length(),
		true
	)

func add_dialog(target: PnC_Interaction, cursor: String, portrait: PackedScene, texts: Array) -> void:
	target.add_function(
		cursor,
		func():
			var instance = portrait.instantiate()
			textDisplay.drawingLayer.add_child(instance)
			for text in texts:
				Global.play_text(text, 0)
				await Global.textDisplay.dialog_closed
			Global.textDisplay.clear_drawing_layer()
	)
