extends OptionButtonCSV
class_name NamedEnemyParamsIdOptionButton



func _ready():
	read_CSV("NAMED_PARAM_%s", "res://resources/named_param.csv")
	
	
func _select(idx: int):
	#debug - called?
	print("_select")
	var index := idx
	if index == -1:
		index = get_item_index(0x8FA)
	super.select(index)
