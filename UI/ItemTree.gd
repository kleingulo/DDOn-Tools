extends Tree
class_name ItemTree

@export var itemsCSV := "res://resources/items.csv"

var items_cache: Array
var initialized := false

func _ready():
	init_item_list()
	
func init_item_list():
	if initialized:
		return
		
	items_cache = []
	var file := FileAccess.open(itemsCSV, FileAccess.READ)
	file.get_csv_line() # Ignore header line
	while !file.eof_reached():
		var csv_line := file.get_csv_line()
		if csv_line.size() >= 1:
			var item := Item.new(int(csv_line[0]))
			items_cache.append(item)
	file.close()
	_rebuild_list()
	initialized = true
	
func _on_FilterLineEdit_text_changed(new_text: String):
	_rebuild_list(new_text)

func _rebuild_list(filter_text: String = ""):
	var normalized_filter_text := filter_text.to_upper()
	clear()
	hide_root = true
	var root := create_item()
	for item in items_cache:
		if normalized_filter_text.length() == 0 or normalized_filter_text in item.name.to_upper():
			var item_item := create_item(root)
			item_item.set_text(0, item.name)
			item_item.set_metadata(0, item)

func _get_drag_data(pos):
	var selected_item: Item =  get_item_at_position(pos).get_metadata(0)
	print_debug("Dragging %s" % [tr(selected_item.name)])
	return selected_item

func get_item_by_id(id: int) -> Item:
	# Also inefficient af
	#GD4 migration
	#var child := get_root().get_children()
	var child := get_root().get_children()[0]
	while child != null:
		var item := child.get_metadata(0) as Item
		if item.id == id:
			return item
		child = child.get_next()
	
	return null
