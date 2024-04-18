extends GenericSetPlacemark
class_name GatheringSpotPlacemark

@export var item_placemark_packed_scene: PackedScene = preload("res://UI/Marker/GatheringItemPlacemark.tscn")

@export var gathering_spot: Resource

@onready var _gathering_spot := gathering_spot as GatheringSpot


func _ready() -> void:
	_gathering_spot.connect("changed", Callable(self, "_on_gathering_spot_changed"))
	_on_gathering_spot_changed()
	
func _on_gathering_spot_changed() -> void:
	# Rebuild children elements
	for child in $VBoxContainer.get_children():
		$VBoxContainer.remove_child(child)
		
	for index in _gathering_spot.get_gathering_items().size():
		var item: GatheringItem = _gathering_spot.get_gathering_items()[index]
		var item_placemark: GatheringItemPlacemark = item_placemark_packed_scene.instantiate()
		item_placemark.item = item
		item_placemark.connect("placemark_removed", Callable(self, "_on_item_removed").bind(index))
		$VBoxContainer.add_child(item_placemark)

func _on_item_removed(index: int) -> void:
	_gathering_spot.remove_item(index)

func add_item(item: GatheringItem) -> void:
	_gathering_spot.add_item(item)

func clear_items() -> void:
	_gathering_spot.clear_items()

func get_items() -> Array:
	return _gathering_spot.get_items()

# Drag and drop functions
func _can_drop_data(_position, data):
	return data is Item
	
func _drop_data(_position, data):
	add_item(GatheringItem.new(data))
	print_debug("Placed %s at %s (%d %d %d) " % [tr(data.name), tr(str("STAGE_NAME_",_gathering_spot.stage_id)), _gathering_spot.stage_id, _gathering_spot.group_id, _gathering_spot.subgroup_id])
