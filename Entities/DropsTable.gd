extends Resource
class_name DropsTable

@export var id: int: set = _set_id
@export var name: String: set = _set_name
@export var mdl_type: int: set = _set_mdl_type

var _items: Array

func _init(drops_table_id: int):
	self.id = drops_table_id
	_items = []

func get_items() -> Array:
	return _items

func add_item(item: GatheringItem) -> void:
	_items.append(item)
	emit_changed()

func remove_item(index: int) -> void:
	#GD4 migration - Array remove() is now remove_at(), same functionality.
	#_items.remove(index)
	_items.remove_at(index)
	emit_changed()

func clear_items() -> void:
	_items.clear()
	emit_changed()

func _set_id(value: int) -> void:
	id = value
	emit_changed()

func _set_name(value: String) -> void:
	name = value
	emit_changed()
	
func _set_mdl_type(value: int) -> void:
	mdl_type = value
	emit_changed()
