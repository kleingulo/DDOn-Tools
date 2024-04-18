extends PanelContainer
class_name DropsTableItemsPanel

signal dropped_item(drop_item)

# Drag and drop functions
func _can_drop_data(_position, data):
	return data is Item
	
func _drop_data(_position, data):
	emit_signal("dropped_item", GatheringItem.new(data))
