extends Node2D

@onready var icons_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Icons")
@onready var tama_sprite: AnimatedSprite2D = get_node("/root/TamaGoonchii/Screen/TamaSprite")

@onready var exit_control: Node2D = get_node("/root/TamaGoonchii/Screen/Exit/ExitControl")
@onready var feed_control: Node2D = get_node("/root/TamaGoonchii/Screen/FeedMenu/FeedControl")
@onready var clean_control: Node2D = get_node("/root/TamaGoonchii/Screen/Clean/CleanControl")

var main_is_active: bool = false

var select_index: int = 0
var icons: Array = []

func _ready() -> void:
	# TODO: Move this later
	activate_main()
	Global.hide_layers()
	
	icons = get_tree().get_nodes_in_group("Icons")
	for icon in icons:
		icon.modulate = Color(0.0, 0.0, 0.0, 0.471)
	icons[select_index].modulate = Color(1.0, 1.0, 1.0, 0.784)

func _on_a_button_up() -> void:
	if not Global.a_active: return
	if main_is_active:
		unhighlight_icon(icons[select_index])
		select_index = (select_index + 1) % icons.size()
		highlight_icon(icons[select_index])

func _on_b_button_up() -> void:
	if not Global.b_active: return
	if main_is_active:
		match select_index:
			0:
				deactivate_main()
				print("Feed") # TODO: Feed func goes here + etc V
				feed_control.feed_menu()
			1:
				deactivate_main()
				print("Play")
			2:
				deactivate_main()
				print("Clean")
				clean_control.clean()
			3:
				deactivate_main()
				print("Sleep")
			4:
				deactivate_main()
				print("Shovel")
			5:
				deactivate_main()
				print("Meds")
			6:
				deactivate_main()
				print("Status")
			7:
				deactivate_main()
				print("Menu")

func _on_c_button_up() -> void:
	if not Global.c_active: return
	if main_is_active:
		deactivate_main()
		exit_control.exit_menu()

func activate_main() -> void:
	icons_layer.show()
	tama_sprite.show()
	main_is_active = true
	Global.a_active = true
	Global.b_active = true
	Global.c_active = true
func deactivate_main() -> void:
	icons_layer.hide()
	tama_sprite.hide()
	main_is_active = false
	Global.a_active = false
	Global.b_active = false
	Global.c_active = false

func unhighlight_icon(icon: Node) -> void:
	icon.modulate = Color(1.0, 1.0, 1.0, 0.471)
func highlight_icon(icon: Node) -> void:
	icon.modulate = Color(1.0, 1.0, 1.0, 0.784)
