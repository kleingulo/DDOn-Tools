extends VBoxContainer
class_name DropsController

signal drops_table_selected(drops_table)

# Special ID used for the "No drops" option
const NO_DROPS_OPTION_ID = 4096

@export var drop_item_panel_packed_scene: PackedScene = preload("res://UI/DropItemPanel.tscn")

var _selected_drops_table: DropsTable = null

func _ready():
	SetProvider.connect("drops_tables_updated", Callable(self, "_update_drops_tables"))
	_update_drops_tables()
	
func _update_drops_tables() -> void:
	_clear_drops_tables()
	for drops_table in SetProvider.get_all_drops_tables():
		if drops_table.id < 0:
			push_error("Found drops table with ID -1. Ignoring.")
		else:
			$HFlowContainer/DropsTableOptionButton.add_item(drops_table.name, drops_table.id)
		
func _clear_drops_tables() -> void:
	$HFlowContainer/DropsTableOptionButton.clear()
	$HFlowContainer/DropsTableOptionButton.add_item("-- No Drops --", NO_DROPS_OPTION_ID)
			
func select_drops_table(id: int, quiet: bool = false) -> void:
	if _selected_drops_table != null and _selected_drops_table.is_connected("changed", Callable(self, "_on_selected_drops_table_changed")):
		_selected_drops_table.disconnect("changed", Callable(self, "_on_selected_drops_table_changed"))
	
	if id == null or id < 0:
		_selected_drops_table = null
		var no_drops_option_idx: int = $HFlowContainer/DropsTableOptionButton.get_item_index(NO_DROPS_OPTION_ID)
		$HFlowContainer/DropsTableOptionButton.select(no_drops_option_idx)
	else:
		_selected_drops_table = SetProvider.get_drops_table(id)
		_selected_drops_table.connect("changed", Callable(self, "_on_selected_drops_table_changed").bind(_selected_drops_table))
		_on_selected_drops_table_changed(_selected_drops_table)
	
	for idx in $HFlowContainer/DropsTableOptionButton.get_item_count():
		if $HFlowContainer/DropsTableOptionButton.get_item_id(idx) == id:
			$HFlowContainer/DropsTableOptionButton.select(idx)
	
	$DropsTableItemsPanel.visible = _selected_drops_table != null
	$HFlowContainer/RemoveDropsTableButton.disabled = _selected_drops_table == null
	
	if not quiet:
		emit_signal("drops_table_selected", _selected_drops_table)


func _on_selected_drops_table_changed(selected_drops_table: DropsTable):
	# Name
	var option_idx: int = $HFlowContainer/DropsTableOptionButton.get_item_index(selected_drops_table.id)
	$HFlowContainer/DropsTableOptionButton.set_item_text(option_idx, selected_drops_table.name)
	$DropsTableItemsPanel/MarginContainer/VBoxContainer/DropsTableNameLineEdit.text = selected_drops_table.name
	
	# Model Type
	$DropsTableItemsPanel/MarginContainer/VBoxContainer/DropsTableOptions/DropModelSpinBox.value = selected_drops_table.mdl_type
	
	# Items
	$DropsTableItemsPanel/MarginContainer/VBoxContainer/DropItemsHereLabel.visible = selected_drops_table.get_items().size() == 0
	
	# Clear previous item panels
	for child_idx in $DropsTableItemsPanel/MarginContainer/VBoxContainer/DropItemsContainer.get_child_count():
		$DropsTableItemsPanel/MarginContainer/VBoxContainer/DropItemsContainer.get_child(child_idx).queue_free()
		
	# Add new item panels
	for index in selected_drops_table.get_items().size():
		var drop_item: GatheringItem = selected_drops_table.get_items()[index]
		var drop_item_panel: DropItemPanel = drop_item_panel_packed_scene.instantiate()
		drop_item_panel.drop_item = drop_item
		drop_item_panel.connect("drop_item_removed", Callable(self, "_on_drop_item_removed").bind(selected_drops_table, index))
		$DropsTableItemsPanel/MarginContainer/VBoxContainer/DropItemsContainer.add_child(drop_item_panel)

func _on_drop_item_removed(drops_table: DropsTable, index: int):
	drops_table.remove_item(index)


func _on_DropsTableOptionButton_item_selected(index):
	var selected_option_id: int = $HFlowContainer/DropsTableOptionButton.get_item_id(index)
	if selected_option_id == NO_DROPS_OPTION_ID:
		select_drops_table(-1)
	else:
		select_drops_table(selected_option_id)
	
func _on_AddDropsTableButton_pressed():
	#GD4 migration - The function "_get_highest_drops_table_id()" is a static function but was called from an instance. Instead, it should be directly called from the type: "VBoxContainer._get_highest_drops_table_id()".
	var next_id := DropsController._get_highest_drops_table_id()+1
	var new_drops_table: DropsTable = SetProvider.get_drops_table(next_id)
	new_drops_table.name = "Drops Table %d" % [new_drops_table.id]
	select_drops_table(new_drops_table.id)
	
func _on_RemoveDropsTableButton_pressed():
	var selected_option_id: int = $HFlowContainer/DropsTableOptionButton.get_selected_id()
	if selected_option_id != NO_DROPS_OPTION_ID:
		SetProvider.remove_drops_table(selected_option_id)
		select_drops_table(-1)

func _on_DropsTableNameLineEdit_text_changed(new_text):
	_selected_drops_table.name = new_text
	$DropsTableItemsPanel/MarginContainer/VBoxContainer/DropsTableNameLineEdit.caret_column = len(new_text)
	
func _on_DropModelSpinBox_value_changed(value):
	_selected_drops_table.mdl_type = int(value)
	
func _on_DropsTableItemsPanel_dropped_item(drop_item: GatheringItem):
	_selected_drops_table.add_item(drop_item)
	print_debug("Placed %s in drops table %s" % [tr(drop_item.item.name), _selected_drops_table.name])


static func _get_highest_drops_table_id() -> int:
	var highest := 0
	for drops_table in SetProvider.get_all_drops_tables():
		highest = max(highest, drops_table.id)
	return int(highest)
