extends GenericPlacemark
class_name GatheringItemPlacemark

@export var item: Resource: set = set_item
	
@onready var _detailsPanel: DetailsPanel = DetailsPanel.get_instance(get_tree())

func _on_GatheringItemPlacemark_pressed():
	# Left Click
	_detailsPanel.show_details_of(item)

func set_item(i: GatheringItem) -> void:
	if item != null and item.is_connected("changed", Callable(self, "_on_item_changed")):
		item.disconnect("changed", Callable(self, "_on_item_changed"))
		
	item = i
	
	if i != null:
		i.connect("changed", Callable(self, "_on_item_changed"))
		_on_item_changed()
	
func _on_item_changed():
	text = item.get_display_name()
