extends Label

class_name PnC_Label

@export var text_id: String = ""

func _ready() -> void:
	if text_id != "":
		_update_lang()
		Lang.connect("lang_update", _update_lang)

func _update_lang() -> void:
	set_text(
		Lang.get_text(text_id)
	)
