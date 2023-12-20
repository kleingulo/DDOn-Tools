extends Resource
class_name Item

const TRANSLATION_KEY_FORMAT = "ITEM_NAME_%d"

export var id: int
export var name: String setget , _get_name

func _init(id: int):
	self.id = id

func _get_name():
	return tr(TRANSLATION_KEY_FORMAT % id)
