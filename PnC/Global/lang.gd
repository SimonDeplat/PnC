extends Node

signal lang_update

var lang = "eng"

var texts

func get_text(text: String) -> String:
	var string = ""
	if texts.has(text):
		if texts[text].has(lang):
			string = texts[text][lang]
		else:
			string = texts[text]["eng"]
	return string

func set_lang(new_lang: String) -> void:
	lang = new_lang
	lang_update.emit()
