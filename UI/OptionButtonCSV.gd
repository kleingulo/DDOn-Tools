extends OptionButton
class_name OptionButtonCSV


func read_CSV(TRANSLATION_KEY_FORMAT, named_param_csv):
	#GD4 migration - File was replaced by FileAccess
	#var file := File.new()
	#file.open(named_param_csv, File.READ)
	#file.get_csv_line() # Ignore header line
	#while !file.eof_reached():
		#var csv_line := file.get_csv_line()
		#if csv_line.size() >= 1:
			#add_item(tr(TRANSLATION_KEY_FORMAT % csv_line[0]), int(csv_line[0]))
	#file.close()
	var file = FileAccess.open(named_param_csv, FileAccess.READ)
	file.get_csv_line() # Ignore header line
	while !file.eof_reached():
		var csv_line := file.get_csv_line()
		if csv_line.size() >= 1:
			add_item(tr(TRANSLATION_KEY_FORMAT % csv_line[0]), int(csv_line[0]))
	file.close()
