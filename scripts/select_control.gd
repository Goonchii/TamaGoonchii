extends Node2D

@onready var icons_layer: CanvasLayer = get_node("/root/TamaGoonchii/Icons")

var main_is_active: bool = false
var current_index: int = 0
var icons: Array = []

func _ready() -> void:
	# TODO: Move this later
	activate_main()
	
	icons = get_tree().get_nodes_in_group("Icons")
	for icon in icons:
		icon.modulate = Color(0.0, 0.0, 0.0, 0.471)
	icons[current_index].modulate = Color(1.0, 1.0, 1.0, 0.784)

func _on_a_button_up() -> void:
	if not main_is_active: return
	unhighlight_icon(icons[current_index])
	current_index += 1 % icons.size()
	if current_index > 7:
		current_index = 0
	highlight_icon(icons[current_index])

func _on_b_button_up() -> void:
	if not main_is_active: return
	main_is_active = false
	match current_index:
		0:
			icons_layer.hide()
			print("Feed")
		1:
			icons_layer.hide()
			print("Play")
		2:
			icons_layer.hide()
			print("Clean")
		3:
			icons_layer.hide()
			print("Sleep")
		4:
			icons_layer.hide()
			print("Shovel")
		5:
			icons_layer.hide()
			print("Meds")
		6:
			icons_layer.hide()
			print("Status")
		7:
			icons_layer.hide()
			print("Menu")

func _on_c_button_up() -> void:
	if not main_is_active: return

func activate_main() -> void:
	icons_layer.show()
	main_is_active = true


func unhighlight_icon(icon: Node) -> void:
	icon.modulate = Color(1.0, 1.0, 1.0, 0.471)

func highlight_icon(icon: Node) -> void:
	icon.modulate = Color(1.0, 1.0, 1.0, 0.784)
