extends OptionButton
class_name LanguageOptionButton

func _ready():
	#GD4 migration - get_loaded_locales returns an entry for every loaded locale file, even if the entry is already present. So I have to filter it
	for locale in LanguageOptionButton.get_loaded_locales_unique():
		add_item(TranslationServer.get_locale_name(locale))
		set_item_metadata(get_item_count()-1, locale)
		if(TranslationServer.get_locale() == locale):
			select(get_item_count()-1)
	
func _on_item_selected(idx: int):
	TranslationServer.set_locale(get_item_metadata(idx))
	
	# Autosave to prevent unsaved changes from getting lost
	for node in get_tree().get_nodes_in_group("filemenu"):
		node.resave()
	# Reload everything, lol, lmao, yolo
	get_tree().reload_current_scene()

#GD4 migration - probalby a shitty way to filter...
static func get_loaded_locales_unique():
	var locales = TranslationServer.get_loaded_locales()
	var returns = []
	for locale in locales:
		if !returns.has(locale):
			returns.append(locale)
	return returns
