extends Node2D
class_name PlayerMarkers

const PlayerMarkerScene = preload("res://UI/Marker/PlayerMarker.tscn")

@onready var ui_node := $"../../ui"

func _on_Players_player_joined(player: PlayerMapEntity):
	var node := _get_player_node(player)
	if node == null:
		node = PlayerMarkerScene.instantiate()
		ui_node.connect("stage_selected", Callable(node, "_on_ui_stage_selected"))
		node.set_player(player)
		add_child(node)

func _on_Players_player_updated(player: PlayerMapEntity):
	var node := _get_player_node(player)
	if node != null:
		node.set_player(player)

func _on_Players_player_left(player: PlayerMapEntity):
	var node := _get_player_node(player)
	if node != null:
		remove_child(node)
		node.queue_free()


func _get_player_node(player: PlayerMapEntity) -> PlayerMarker:
	for n in get_children():
		if n.player.CharacterId == player.CharacterId:
			return n
	return null
