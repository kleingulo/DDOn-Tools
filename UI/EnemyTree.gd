extends Tree
class_name EnemyTree

@export var enemyCSV := "res://resources/enemies.csv"

var enemy_cache: Array
var initialized := false

func _ready():
	init_enemy_list()
		
func init_enemy_list():
	if initialized:
		return
		
	enemy_cache = []
	var file = FileAccess.open(enemyCSV, FileAccess.READ)
	file.get_csv_line() # Ignore header line
	while !file.eof_reached():
		var csv_line := file.get_csv_line()
		if csv_line.size() >= 3:
			var enemy := EnemyType.new(csv_line[0].hex_to_int(), csv_line[1], int(csv_line[2]))
			enemy_cache.append(enemy)
	file.close()
	_rebuild_list()
	initialized = true
	
func _on_FilterLineEdit_text_changed(new_text):
	_rebuild_list(new_text)
	
func _rebuild_list(filter_text: String = ""):
	var normalized_filter_text := filter_text.to_upper()
	clear()
	hide_root = true
	var root := create_item()
	for enemy in enemy_cache:
		if normalized_filter_text.length() == 0 or normalized_filter_text in enemy.name.to_upper():
			var enemy_item := create_item(root)
			enemy_item.set_text(0, enemy.name)
			enemy_item.set_metadata(0, enemy)
	
func _get_drag_data(pos):
	var selected_enemy_type: EnemyType =  get_item_at_position(pos).get_metadata(0)
	print_debug("Dragging %s" % [tr(selected_enemy_type.name)])
	return selected_enemy_type

func get_enemy_by_id(id: int) -> EnemyType:
	# Also inefficient af
	#GD4 migration - fetch only the first child and not the whole array as get_metadata does not work on arrays
	#var child := get_root().get_children()
	var child := get_root().get_children()[0]
	while child != null:
		var enemy := child.get_metadata(0) as EnemyType
		if enemy.id == id:
			return enemy
		child = child.get_next()
	
	return null
