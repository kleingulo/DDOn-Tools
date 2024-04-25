extends ScrollContainer
class_name ItemDetailsPanel

@export var title_label: NodePath

var item: GatheringItem: set = _set_item

@onready var title_label_node: Label = get_node_or_null(title_label)

func _set_item(i: GatheringItem) -> void:
	if item != null and item.is_connected("changed", Callable(self, "_on_item_changed")):
		item.disconnect("changed", Callable(self, "_on_item_changed"))
	
	item = i
	
	if i != null:
		i.connect("changed", Callable(self, "_on_item_changed"))
	
	_on_item_changed()
	
func _on_item_changed():
	if item != null:
		$GridContainer/NumContainer/NumSpinBox.value = item.num
		$GridContainer/NumContainer/MaxNumSpinBox.value = item.max_num
		$GridContainer/QualitySpinBox.value = item.quality
		$GridContainer/IsHiddenCheckBox.button_pressed = item.is_hidden
		
		if title_label_node != null:
			title_label_node.text = item.get_display_name()


func _on_DropChanceSpinBox_value_changed(value):
	item.drop_chance = $GridContainer/DropChanceSpinBox.value / 100
	
func _on_NumSpinBox_value_changed(value):
	item.num = $GridContainer/NumContainer/NumSpinBox.value

func _on_MaxNumSpinBox_value_changed(value):
	item.max_num = $GridContainer/NumContainer/MaxNumSpinBox.value
	
func _on_QualitySpinBox_value_changed(value):
	item.quality = $GridContainer/QualitySpinBox.value

func _on_IsHiddenCheckBox_pressed():
	item.is_hidden = $GridContainer/IsHiddenCheckBox.button_pressed
