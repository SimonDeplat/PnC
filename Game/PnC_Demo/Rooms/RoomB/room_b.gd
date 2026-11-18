extends Node2D

var portrait_scene = preload("res://Game/PnC_Demo/Misc/portrait.tscn")

func _ready() -> void:
	
	# Simple timed interaction
	$PnC_Interaction.add_text(
		"interact",
		"painting",
		2.0
	)
	
	# Dialog display
	Global.add_dialog(
		$PnC_Interaction2,
		"interact",
		portrait_scene,
		["speech"]
	)
