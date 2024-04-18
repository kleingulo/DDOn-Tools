extends RefCounted

class_name Common

static func load_json_file(path):
	"""Loads a JSON file from the given res path and return the loaded JSON object."""
	#GD4 migration 
	#File is now FileAccess and open() is now a static method that returns such object. To then check for errors, call file_access.get_error()
	#var file = File.new()
	#file.open(path, file.READ)
	var file = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	#GD4 migration
	#JSON changed in several ways. parse() now returns an Error object and the variables "error" and "error_line" were replaced by functions
	#var test_json_conv = JSON.new()
	#test_json_conv.parse(text)
	#var result_json = test_json_conv.get_data()
	#if result_json.error != OK:
		#print("[load_json_file] Error loading JSON file '" + str(path) + "'.")
		#print("\tError: ", result_json.error)
		#print("\tError Line: ", result_json.error_line)
		#print("\tError String: ", result_json.error_string)
		#return null
	#var obj = result_json.result
	#return obj
	var json = JSON.new()
	var error = json.parse(text)
	if error == OK:
		var data_received = json.get_data()
		return data_received
	else:
		print("[load_json_file] Error loading JSON file '" + str(path) + "'.")
		print("\tError: ", json.get_error_message())
		print("\tError Line: ", json.get_error_line())
		return null

static func save_json_file(path, contents):
	"""Saves contents to the given path as JSON."""
	#var file = File.new()
	#file.open(path, file.WRITE)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(contents))
	file.close()
