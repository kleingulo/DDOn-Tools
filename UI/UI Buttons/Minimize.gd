extends Button
class_name Minimize

@export var control_to_minimize: NodePath
@export var property_to_toggle: String = "anchor_bottom"

@export var minimize_text := "-"
@export var maximize_text := "+"

@onready var control_to_minimize_node: Control = get_node(control_to_minimize)


func _ready():
	connect("pressed", Callable(self, "_on_pressed"))
	_update_label()

func _on_pressed():
	control_to_minimize_node[property_to_toggle] = !control_to_minimize_node[property_to_toggle]
	_update_label()

func _update_label():
	if control_to_minimize_node[property_to_toggle]:
		text = minimize_text
	else:
		text = maximize_text
