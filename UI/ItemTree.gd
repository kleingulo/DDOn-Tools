extends Tree
class_name ItemTree

export (String, FILE, "*.csv") var itemsCSV := "res://resources/items.csv"

func _ready():
	hide_root = true
	var root := create_item()
	
	var file := File.new()
	file.open(itemsCSV, File.READ)
	file.get_csv_line() # Ignore header line
	while !file.eof_reached():
		var csv_line := file.get_csv_line()
		if csv_line.size() >= 1:
			var item := Item.new(int(csv_line[0]))
			var item_item := create_item(root)
			item_item.set_text(0, item.name)
			item_item.set_metadata(0, item)
	file.close()	
	
func get_drag_data(position):
	var selected_item: Item =  get_item_at_position(position).get_metadata(0)
	print_debug("Dragging %s" % [tr(selected_item.name)])
	return selected_item

func get_item_by_id(id: int) -> Item:
	# Also inefficient af
	var child := get_root().get_children()
	while child != null:
		var item := child.get_metadata(0) as Item
		if item.id == id:
			return item
		child = child.get_next()
	
	return null
