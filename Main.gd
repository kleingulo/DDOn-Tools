extends Control

const MAX_LAYERS = 10

# i have to do this bs otherwise godot refuses to export the files
const image_array_jorobate_flanders := ["res://resources/maps/field000_m00_l0.png","res://resources/maps/field001_m00_l0.png","res://resources/maps/field002_m01_l1.png","res://resources/maps/field003_m00_l0.png","res://resources/maps/field004_m00_l0.png","res://resources/maps/field005_m00_l0.png","res://resources/maps/field007_m00_l0.png","res://resources/maps/lb000_m00_l0.png","res://resources/maps/lb001_m00_l0.png","res://resources/maps/lb002_m00_l0.png","res://resources/maps/lb003_m00_l0.png","res://resources/maps/lb003_m00_l1.png","res://resources/maps/lb003_m00_l2.png","res://resources/maps/lb010_m00_l0.png","res://resources/maps/lb010_m00_l1.png","res://resources/maps/lb010_m00_l2.png","res://resources/maps/lb011_m00_l0.png","res://resources/maps/lb011_m01_l0.png","res://resources/maps/lb011_m02_l0.png","res://resources/maps/pd000_m00_l0.png","res://resources/maps/pd000_m01_l0.png","res://resources/maps/pd000_m02_l0.png","res://resources/maps/pd000_m03_l0.png","res://resources/maps/pd000_m04_l0.png","res://resources/maps/pd000_m04_l1.png","res://resources/maps/pd000_m05_l0.png","res://resources/maps/pd000_m06_l0.png","res://resources/maps/pd000_m07_l0.png","res://resources/maps/pd000_m08_l0.png","res://resources/maps/pd000_m09_l0.png","res://resources/maps/pd000_m10_l0.png","res://resources/maps/pd000_m11_l0.png","res://resources/maps/pd000_m12_l0.png","res://resources/maps/pd000_m13_l0.png","res://resources/maps/pd000_m14_l0.png","res://resources/maps/pd000_m15_l0.png","res://resources/maps/pd000_m16_l0.png","res://resources/maps/pd000_m17_l0.png","res://resources/maps/pd000_m18_l0.png","res://resources/maps/pd000_m21_l0.png","res://resources/maps/pd000_m22_l0.png","res://resources/maps/pd000_m23_l0.png","res://resources/maps/pd001_m00_l0.png","res://resources/maps/pd001_m01_l0.png","res://resources/maps/pd001_m02_l0.png","res://resources/maps/pd001_m03_l0.png","res://resources/maps/pd001_m04_l0.png","res://resources/maps/pd001_m05_l0.png","res://resources/maps/pd001_m06_l0.png","res://resources/maps/pd001_m06_l1.png","res://resources/maps/pd001_m07_l0.png","res://resources/maps/pd001_m08_l0.png","res://resources/maps/pd001_m09_l0.png","res://resources/maps/pd001_m10_l0.png","res://resources/maps/pd001_m11_l0.png","res://resources/maps/pd001_m12_l0.png","res://resources/maps/pd001_m12_l1.png","res://resources/maps/pd001_m13_l0.png","res://resources/maps/pd001_m14_l0.png","res://resources/maps/pd001_m15_l0.png","res://resources/maps/pd001_m16_l0.png","res://resources/maps/pd001_m17_l0.png","res://resources/maps/pd001_m18_l0.png","res://resources/maps/pd001_m19_l0.png","res://resources/maps/pd001_m20_l0.png","res://resources/maps/pd001_m21_l0.png","res://resources/maps/pd001_m22_l0.png","res://resources/maps/pd001_m23_l0.png","res://resources/maps/pd001_m24_l0.png","res://resources/maps/pd001_m25_l0.png","res://resources/maps/pd001_m26_l0.png","res://resources/maps/pd001_m27_l0.png","res://resources/maps/pd001_m28_l0.png","res://resources/maps/pd001_m29_l0.png","res://resources/maps/pd001_m30_l0.png","res://resources/maps/pd001_m31_l0.png","res://resources/maps/pd001_m32_l0.png","res://resources/maps/pd001_m33_l0.png","res://resources/maps/pd001_m34_l0.png","res://resources/maps/pd001_m35_l0.png","res://resources/maps/pd001_m36_l0.png","res://resources/maps/pd001_m41_l0.png","res://resources/maps/pd002_m00_l0.png","res://resources/maps/pd002_m01_l0.png","res://resources/maps/pd002_m02_l0.png","res://resources/maps/pd002_m03_l0.png","res://resources/maps/pd002_m04_l0.png","res://resources/maps/pd002_m05_l0.png","res://resources/maps/pd002_m05_l1.png","res://resources/maps/pd002_m06_l0.png","res://resources/maps/pd002_m06_l1.png","res://resources/maps/pd002_m07_l0.png","res://resources/maps/pd002_m07_l1.png","res://resources/maps/pd002_m08_l0.png","res://resources/maps/pd002_m09_l0.png","res://resources/maps/pd002_m09_l1.png","res://resources/maps/pd002_m10_l0.png","res://resources/maps/pd003_m00_l0.png","res://resources/maps/pd003_m01_l0.png","res://resources/maps/pd003_m02_l0.png","res://resources/maps/pd003_m03_l0.png","res://resources/maps/pd003_m04_l0.png","res://resources/maps/pd003_m05_l0.png","res://resources/maps/pd003_m06_l0.png","res://resources/maps/pd003_m07_l0.png","res://resources/maps/pd003_m08_l0.png","res://resources/maps/pd003_m09_l0.png","res://resources/maps/pd003_m10_l0.png","res://resources/maps/pd003_m11_l0.png","res://resources/maps/pd003_m12_l0.png","res://resources/maps/pd003_m13_l0.png","res://resources/maps/pd003_m14_l0.png","res://resources/maps/pd003_m15_l0.png","res://resources/maps/pd003_m16_l0.png","res://resources/maps/pd003_m17_l0.png","res://resources/maps/pd003_m18_l0.png","res://resources/maps/pd003_m19_l0.png","res://resources/maps/pd003_m20_l0.png","res://resources/maps/pd003_m21_l0.png","res://resources/maps/pd003_m22_l0.png","res://resources/maps/pd003_m23_l0.png","res://resources/maps/pd003_m23_l1.png","res://resources/maps/pd003_m24_l0.png","res://resources/maps/pd003_m25_l0.png","res://resources/maps/pd003_m26_l0.png","res://resources/maps/pd003_m27_l0.png","res://resources/maps/pd003_m28_l0.png","res://resources/maps/pd003_m29_l0.png","res://resources/maps/pd003_m30_l0.png","res://resources/maps/pd003_m33_l0.png","res://resources/maps/pd003_m34_l0.png","res://resources/maps/pd004_m00_l0.png","res://resources/maps/pd004_m01_l0.png","res://resources/maps/pd004_m02_l0.png","res://resources/maps/pd004_m03_l0.png","res://resources/maps/pd004_m04_l0.png","res://resources/maps/pd004_m04_l1.png","res://resources/maps/pd004_m05_l0.png","res://resources/maps/pd004_m05_l1.png","res://resources/maps/pd004_m06_l0.png","res://resources/maps/pd004_m07_l0.png","res://resources/maps/pd004_m08_l0.png","res://resources/maps/pd004_m09_l0.png","res://resources/maps/pd004_m10_l0.png","res://resources/maps/pd004_m11_l0.png","res://resources/maps/pd005_m00_l0.png","res://resources/maps/pd005_m01_l0.png","res://resources/maps/pd005_m02_l0.png","res://resources/maps/pd005_m03_l0.png","res://resources/maps/pd005_m04_l0.png","res://resources/maps/pd005_m05_l0.png","res://resources/maps/pd005_m06_l0.png","res://resources/maps/pd006_m00_l0.png","res://resources/maps/pd006_m01_l0.png","res://resources/maps/pd006_m02_l0.png","res://resources/maps/pd006_m03_l0.png","res://resources/maps/pd006_m04_l0.png","res://resources/maps/pd006_m05_l0.png","res://resources/maps/pd006_m05_l1.png","res://resources/maps/pd006_m06_l0.png","res://resources/maps/pd006_m06_l1.png","res://resources/maps/pd006_m07_l0.png","res://resources/maps/pd006_m07_l1.png","res://resources/maps/pd006_m08_l0.png","res://resources/maps/pd006_m09_l0.png","res://resources/maps/pd007_m00_l0.png","res://resources/maps/pd007_m01_l0.png","res://resources/maps/pd007_m01_l1.png","res://resources/maps/pd007_m02_l0.png","res://resources/maps/pd007_m02_l1.png","res://resources/maps/pd007_m03_l0.png","res://resources/maps/pd007_m03_l1.png","res://resources/maps/pd007_m04_l0.png","res://resources/maps/pd007_m05_l0.png","res://resources/maps/pd007_m06_l0.png","res://resources/maps/pd007_m07_l0.png","res://resources/maps/pd007_m08_l0.png","res://resources/maps/pd007_m08_l1.png","res://resources/maps/pd007_m09_l0.png","res://resources/maps/pd007_m10_l0.png","res://resources/maps/pd007_m11_l0.png","res://resources/maps/pd007_m12_l0.png","res://resources/maps/pd007_m15_l0.png","res://resources/maps/pd007_m15_l1.png","res://resources/maps/pd010_m00_l0.png","res://resources/maps/pd010_m01_l0.png","res://resources/maps/pd010_m02_l0.png","res://resources/maps/pd010_m02_l1.png","res://resources/maps/pd010_m04_l0.png","res://resources/maps/pd010_m05_l0.png","res://resources/maps/pd010_m05_l1.png","res://resources/maps/pd010_m07_l0.png","res://resources/maps/pd010_m07_l1.png","res://resources/maps/pd010_m08_l0.png","res://resources/maps/pd010_m08_l1.png","res://resources/maps/pd010_m09_l0.png","res://resources/maps/pd010_m10_l0.png","res://resources/maps/pd010_m11_l0.png","res://resources/maps/pd010_m12_l0.png","res://resources/maps/pd010_m13_l0.png","res://resources/maps/pd011_m00_l0.png","res://resources/maps/pd011_m01_l0.png","res://resources/maps/pd011_m02_l0.png","res://resources/maps/pd011_m03_l0.png","res://resources/maps/pd011_m04_l0.png","res://resources/maps/pd011_m05_l0.png","res://resources/maps/pd011_m06_l0.png","res://resources/maps/pd011_m07_l0.png","res://resources/maps/pd011_m08_l0.png","res://resources/maps/pd011_m09_l0.png","res://resources/maps/pd011_m10_l0.png","res://resources/maps/pd011_m11_l0.png","res://resources/maps/pd011_m12_l0.png","res://resources/maps/pd011_m13_l0.png","res://resources/maps/pd011_m14_l0.png","res://resources/maps/pd011_m15_l0.png","res://resources/maps/pd011_m16_l0.png","res://resources/maps/pd011_m17_l0.png","res://resources/maps/pd011_m18_l0.png","res://resources/maps/pd011_m19_l0.png","res://resources/maps/pd011_m20_l0.png","res://resources/maps/pd011_m20_l1.png","res://resources/maps/pd011_m20_l2.png","res://resources/maps/pd011_m21_l0.png","res://resources/maps/pd011_m21_l1.png","res://resources/maps/pd011_m21_l2.png","res://resources/maps/rm000_m00_l0.png","res://resources/maps/rm000_m00_l1.png","res://resources/maps/rm000_m01_l0.png","res://resources/maps/rm000_m01_l1.png","res://resources/maps/rm000_m02_l0.png","res://resources/maps/rm000_m03_l0.png","res://resources/maps/rm001_m00_l0.png","res://resources/maps/rm001_m01_l0.png","res://resources/maps/rm001_m02_l0.png","res://resources/maps/rm001_m02_l1.png","res://resources/maps/rm002_m00_l0.png","res://resources/maps/rm002_m01_l0.png","res://resources/maps/rm002_m01_l1.png","res://resources/maps/rm002_m02_l0.png","res://resources/maps/rm002_m02_l1.png","res://resources/maps/rm002_m22_l0.png","res://resources/maps/rm002_m22_l1.png","res://resources/maps/rm004_m00_l0.png","res://resources/maps/rm004_m01_l0.png","res://resources/maps/rm004_m02_l0.png","res://resources/maps/rm010_m00_l0.png","res://resources/maps/rm010_m00_l1.png","res://resources/maps/rm010_m00_l2.png","res://resources/maps/rm010_m01_l0.png","res://resources/maps/rm010_m01_l1.png","res://resources/maps/rm010_m01_l2.png","res://resources/maps/rm010_m02_l0.png","res://resources/maps/rm010_m02_l1.png","res://resources/maps/rm010_m02_l2.png","res://resources/maps/rm010_m03_l0.png","res://resources/maps/rm011_m00_l0.png","res://resources/maps/rm011_m00_l1.png","res://resources/maps/rm011_m00_l2.png","res://resources/maps/rm011_m00_l3.png","res://resources/maps/rm011_m00_l4.png","res://resources/maps/rm011_m00_l5.png","res://resources/maps/rm011_m00_l6.png","res://resources/maps/rm012_m00_l0.png","res://resources/maps/rm012_m00_l1.png","res://resources/maps/rm101_m00_l0.png","res://resources/maps/rm101_m00_l1.png","res://resources/maps/rm101_m00_l2.png","res://resources/maps/rm102_m00_l0.png","res://resources/maps/rm102_m00_l1.png","res://resources/maps/rm103_m00_l0.png","res://resources/maps/rm103_m00_l1.png","res://resources/maps/rm103_m00_l2.png","res://resources/maps/rm103_m00_l3.png","res://resources/maps/rm103_m01_l0.png","res://resources/maps/rm103_m01_l1.png","res://resources/maps/rm103_m01_l2.png","res://resources/maps/rm104_m00_l0.png","res://resources/maps/rm105_m00_l0.png","res://resources/maps/rm105_m00_l1.png","res://resources/maps/rm106_m00_l0.png","res://resources/maps/rm106_m00_l1.png","res://resources/maps/rm106_m00_l2.png","res://resources/maps/rm107_m00_l0.png","res://resources/maps/rm108_m00_l0.png","res://resources/maps/rm108_m00_l1.png","res://resources/maps/rm108_m00_l2.png","res://resources/maps/rm108_m01_l0.png","res://resources/maps/rm109_m00_l0.png","res://resources/maps/rm110_m00_l0.png","res://resources/maps/rm110_m01_l0.png","res://resources/maps/rm110_m01_l1.png","res://resources/maps/rm111_m00_l0.png","res://resources/maps/rm111_m00_l1.png","res://resources/maps/rm111_m00_l2.png","res://resources/maps/rm112_m00_l0.png","res://resources/maps/rm112_m00_l1.png","res://resources/maps/rm112_m00_l2.png","res://resources/maps/rm112_m00_l3.png","res://resources/maps/rm112_m00_l4.png","res://resources/maps/rm112_m00_l5.png","res://resources/maps/rm113_m00_l0.png","res://resources/maps/rm114_m00_l0.png","res://resources/maps/rm120_m00_l0.png","res://resources/maps/rm121_m00_l0.png","res://resources/maps/rm121_m00_l1.png","res://resources/maps/rm121_m00_l2.png","res://resources/maps/rm121_m02_l0.png","res://resources/maps/rm122_m00_l0.png","res://resources/maps/rm130_m00_l0.png","res://resources/maps/rm130_m00_l1.png","res://resources/maps/rm130_m00_l2.png","res://resources/maps/rm130_m01_l0.png","res://resources/maps/rm130_m01_l1.png","res://resources/maps/rm130_m01_l2.png","res://resources/maps/rm130_m01_l3.png","res://resources/maps/rm130_m02_l0.png","res://resources/maps/rm130_m02_l1.png","res://resources/maps/rm130_m02_l2.png","res://resources/maps/rm130_m02_l3.png","res://resources/maps/rm130_m10_l0.png","res://resources/maps/rm130_m10_l1.png","res://resources/maps/rm130_m10_l2.png","res://resources/maps/rm130_m10_l3.png","res://resources/maps/rm130_m10_l4.png","res://resources/maps/rm131_m00_l0.png","res://resources/maps/rm131_m01_l0.png","res://resources/maps/rm131_m01_l1.png","res://resources/maps/rm131_m01_l2.png","res://resources/maps/rm131_m02_l0.png","res://resources/maps/rm131_m02_l1.png","res://resources/maps/rm131_m03_l0.png","res://resources/maps/rm133_m00_l0.png","res://resources/maps/rm133_m00_l1.png","res://resources/maps/rm133_m00_l2.png","res://resources/maps/rm133_m00_l3.png","res://resources/maps/rm133_m00_l4.png","res://resources/maps/rm133_m00_l5.png","res://resources/maps/rm133_m00_l6.png","res://resources/maps/rm133_m00_l7.png","res://resources/maps/rm133_m00_l8.png","res://resources/maps/rm133_m00_l9.png","res://resources/maps/rm133_m04_l0.png","res://resources/maps/rm133_m50_l0.png","res://resources/maps/rm133_m50_l1.png","res://resources/maps/rm133_m50_l2.png","res://resources/maps/rm133_m50_l3.png","res://resources/maps/rm133_m51_l0.png","res://resources/maps/rm133_m52_l0.png","res://resources/maps/rm134_m50_l0.png","res://resources/maps/rm310_m00_l0.png","res://resources/maps/rm340_m00_l0.png","res://resources/maps/rm900_m00_l0.png","res://resources/maps/rm900_m00_l1.png","res://resources/maps/rm900_m00_l2.png","res://resources/maps/rm900_m00_l3.png","res://resources/maps/rm901_m00_l0.png","res://resources/maps/rm901_m00_l1.png","res://resources/maps/rm901_m00_l2.png","res://resources/maps/rm902_m00_l0.png","res://resources/maps/rm902_m00_l1.png","res://resources/maps/rm902_m00_l2.png","res://resources/maps/rm902_m00_l3.png","res://resources/maps/rm903_m00_l0.png","res://resources/maps/rm904_m00_l0.png","res://resources/maps/rm910_m00_l0.png","res://resources/maps/rm910_m00_l1.png","res://resources/maps/rm910_m00_l2.png","res://resources/maps/rm910_m00_l3.png","res://resources/maps/rm911_m00_l0.png","res://resources/maps/rm911_m00_l1.png","res://resources/maps/rm911_m00_l2.png","res://resources/maps/rm911_m00_l3.png","res://resources/maps/rm912_m00_l0.png","res://resources/maps/rm913_m00_l0.png","res://resources/maps/sfd002_m05_l0.png","res://resources/maps/sfd002_m05_l1.png","res://resources/maps/sfd002_m06_l0.png","res://resources/maps/sfield000_m00_l0.png","res://resources/maps/sfield003_m00_l0.png","res://resources/maps/sfield004_m00_l0.png","res://resources/maps/sfield005_m00_l0.png","res://resources/maps/sfield007_m00_l0.png"]
const EnemySetPlacemarkScene = preload("res://UI/Marker/EnemySetPlacemark.tscn")

onready var camera: Camera2D = $camera
onready var camera_tween: Tween = $CameraTween
onready var map_layers: Node2D = $MapCoordinateSpace/MapLayers
onready var markers_node: Node2D = $MapCoordinateSpace/EnemySetMarkers
onready var players_node: Node2D = $MapCoordinateSpace/PlayerMarkers
	
func _ready():
	# Select Lestania by default, simulating a click on its selector
	# TODO: In a less hacky way, using a Provider. Decoupling map selection logic from the selector/ui node itself
	$ui/left/tab/Stages.select(0)
	$ui/left/tab/Stages.emit_signal("item_selected", 0)
	
	# Select Layer 0 by default, also a hacky way
	$ui/status_view/container/LayerOptionButton.select(0)
	$ui/status_view/container/LayerOptionButton.emit_signal("item_selected", 0)

func _on_ui_stage_selected(stage_no):
	_clear_map()
	_load_stage_map(stage_no)
	_clear_markers()
	_load_stage_markers(stage_no)
	_update_layer_selector()
	_focus_camera_on_center()
	
	var stage_id = DataProvider.stage_no_to_stage_id(int(stage_no))
	if stage_id == -1:
		print("Selected stage ??? (ID: ???, Stage No. %s) with %s markers" % [stage_no, markers_node.get_child_count()])
	else:
		print("Selected stage %s (ID: %s, Stage No. %s) with %s markers" % [tr(str("STAGE_NAME_",stage_id)), stage_id, stage_no, markers_node.get_child_count()])


func _load_stage_map(stage_no) -> void:
	var stage_no_as_int := int(stage_no)
	var field_id := DataProvider.stage_no_to_belonging_field_id(stage_no_as_int)
	if field_id == -1:
		_add_stage_maps(stage_no_as_int)
	else:
		_add_field_maps(field_id-1) # why is it off by one? maybe it needs an additional conversion?

func _add_field_maps(field_id: int) -> void:
	# Since Mergoda Ruins uses m01_l01 instead of m00_l00 like the rest
	if not _do_add_field_maps(field_id, 0, 0):
		_do_add_field_maps(field_id, 1, 1)
		
func _do_add_field_maps(field_id: int, m: int, l: int) -> bool:
	var stage_map_resource := "res://resources/maps/field00"+String(field_id)+"_m0"+String(m)+"_l"+String(l)+".png"
	var resource := _load_map_resource(stage_map_resource)
	if resource == null:
		printerr("Couldn't find a map for this field (Field ID %s)" % [field_id])
		return false
	else:
		var map_sprite := Sprite.new()
		map_sprite.texture = load(stage_map_resource)
		map_sprite.centered = false
		map_layers.get_child(l).add_child(map_sprite)
		print("Loaded map ", stage_map_resource)
		return true
		
		
func _add_stage_maps(stage_no: int) -> void:
	var stage_map := DataProvider.stage_no_to_stage_map(stage_no)
	var origin := Vector2(0,-512) # 512 (map tile height in px)
	if "ParamList" in stage_map:
		for layer_index in range(MAX_LAYERS):
			var layer := map_layers.get_child(layer_index)
			for param in stage_map["ParamList"]:
				# TODO: Load all layers and have a control to switch between them
				var stage_map_resource := "res://resources/maps/"+String(param["ModelName"])+"_l"+String(layer_index)+".png"
				var resource := _load_map_resource(stage_map_resource)
				if resource == null:
					printerr("Couldn't find the map ", stage_map_resource)
				else:
					var map_sprite := Sprite.new()
					map_sprite.texture = load(stage_map_resource)
					map_sprite.centered = false
					map_sprite.global_position = origin + Vector2(param["ConnectPos"]["x"], param["ConnectPos"]["z"])*0.028 # Eyeballed it, close enough
					layer.add_child(map_sprite)
					print("Loaded map ", stage_map_resource)
	else:
		printerr("Couldn't find a map for this stage (Stage No. %s)" % [stage_no])

func _load_stage_markers(stage_no):
	# Build new stage markers
	var stage_id = DataProvider.stage_no_to_stage_id(int(stage_no))
	if stage_no in DataProvider.repo["StageEctMarkers"] and DataProvider.repo["StageEctMarkers"][stage_no] != null:
		for ect_marker in DataProvider.repo["StageEctMarkers"][stage_no]["MarkerInfos"]:
			var marker : Marker = Marker.new(ect_marker, int(stage_no))
			var enemy_set_placemark: EnemySetPlacemark = EnemySetPlacemarkScene.instance()
			enemy_set_placemark.enemy_set = EnemySetProvider.get_enemy_set(stage_id, 0, marker.GroupNo, 0)
			enemy_set_placemark.rect_position = marker.get_map_position()
			markers_node.add_child(enemy_set_placemark)


func _load_map_resource(resource_path: String) -> Resource:
	var directory = Directory.new();
	if image_array_jorobate_flanders.has(resource_path):
		return load(resource_path)
	else:
		return null


func _clear_map():
	for layer in map_layers.get_children():
		for map in layer.get_children():
			layer.remove_child(map)

func _clear_markers() -> void:
	# Clear previous selected stage markers
	for child in markers_node.get_children():
		markers_node.remove_child(child)


func _on_ui_player_activated(player: Player):
	for stage_index in $ui/left/tab/Stages.get_item_count():
		if $ui/left/tab/Stages.get_item_metadata(stage_index) == String(player.StageNo):
			# TODO: Decouple, same as _ready
			$ui/left/tab/Stages.select(stage_index)
			$ui/left/tab/Stages.emit_signal("item_selected", stage_index)
			# Move camera to player position
			camera_tween.remove_all()
			_move_camera_to(player.get_map_position())
			return
	printerr("Couldnt focus map on %s %s (StageNo: %s)" % [player.FirstName, player.LastName, player.StageNo])


func _update_layer_selector() -> void:
	# TODO: Decouple
	var layer_to_select := -1
	for layer_index in range(map_layers.get_child_count()):
		var layer_is_empty := map_layers.get_child(layer_index).get_child_count() == 0
		$ui/status_view/container/LayerOptionButton.set_item_disabled(layer_index, layer_is_empty)
		if layer_to_select == -1 and not layer_is_empty:
			layer_to_select = layer_index

	if layer_to_select != -1:
		# TODO: Fix this mess, same as with _ready
		$ui/status_view/container/LayerOptionButton.select(layer_to_select)
		$ui/status_view/container/LayerOptionButton.emit_signal("item_selected", layer_to_select)

func _focus_camera_on_center() -> void:
	var new_position = null
	if markers_node.get_child_count() > 0:
		new_position = _get_center(markers_node)
	elif map_layers.get_child(0).get_child_count() > 0:
		# TODO: Not depend on there being a layer 0
		new_position = _get_center(map_layers.get_child(0))
	
	if new_position != null:
		_move_camera_to(new_position)


func _move_camera_to(new_position: Vector2) -> void:
	camera_tween.interpolate_property(camera, "position",
		camera.position, new_position, 0.5,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	camera_tween.start()


func _on_LayerOptionButton_item_selected(index):
	for layer in map_layers.get_children():
		layer.visible = false
	map_layers.get_child(index).visible = true


static func _get_center(parent: Node2D) -> Vector2:
	var min_x: int = 9223372036854775807
	var max_x: int = -9223372036854775807
	var min_y: int = 9223372036854775807
	var max_y: int = -9223372036854775807
	
	for child in parent.get_children():
		var position: Vector2 = child.get_rect().get_center()
		min_x = min(min_x, position.x)
		max_x = max(max_x, position.x)
		min_y = min(min_y, position.y)
		max_y = max(max_y, position.y)
		
	return parent.to_global(Rect2(min_x, min_y, max_x-min_x, max_y-min_y).get_center())
