extends OptionButtonCSV
class_name HmPresetNoOptionButton


func _ready():
	#GD4 migration - reduce redundant code
	read_CSV("HM_PRESET_NO_%s", "res://resources/HmPresetNo.csv")

