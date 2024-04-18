extends GenericPlacemark
class_name EnemyPlacemark

const COLOR_BLOOD_ORB = Color.REBECCA_PURPLE
const COLOR_HIGH_ORB = Color.DARK_RED
const COLOR_DEFAULT = Color.WHITE

@export var enemy: Resource: set = set_enemy

@onready var _detailsPanel: DetailsPanel = DetailsPanel.get_instance(get_tree())

func _on_EnemyPlacemark_pressed():
	# Left Click
	_detailsPanel.show_details_of(enemy)
	
func set_enemy(em: Enemy) -> void:
	if enemy != null and enemy.is_connected("changed", Callable(self, "_on_enemy_changed")):
		enemy.disconnect("changed", Callable(self, "_on_enemy_changed"))
		
	enemy = em
		
	if em != null:
		em.connect("changed", Callable(self, "_on_enemy_changed"))
		_on_enemy_changed()
	
func _on_enemy_changed():
	text = enemy.get_display_name()
	
	if enemy.is_blood_enemy:
		modulate = COLOR_BLOOD_ORB
	elif enemy.is_highorb_enemy:
		modulate = COLOR_HIGH_ORB
	else: 
		modulate = COLOR_DEFAULT
