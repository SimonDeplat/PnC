extends Button

var langs = [
	"eng",
	"fr",
]

# Flags are from Wikipedia
var flags = [
	preload("res://PnC/Assets/flags/eng.png"),
	preload("res://PnC/Assets/flags/fr.png"),
]
var lang_index = 0

func _ready() -> void:
	_update_lang()
	Lang.connect("lang_update", _update_lang)

func _update_lang() -> void:
	lang_index = langs.find(Lang.lang)
	set_button_icon(flags[lang_index])

func _on_pressed() -> void:
	lang_index = lang_index + 1
	if lang_index > (langs.size() - 1):
		lang_index = 0
	Lang.set_lang(langs[lang_index])
