extends Node2D

@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var exit_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Exit")

@onready var arrow_label: Label = get_node("/root/TamaGoonchii/Screen/Exit/Arrow")
@onready var yes_label: Label = get_node("/root/TamaGoonchii/Screen/Exit/VBoxContainer/Yes")
@onready var no_label: Label = get_node("/root/TamaGoonchii/Screen/Exit/VBoxContainer/No")

var exit_active: bool = false
var exit_index: int = 0
var exit_items: Array[Label] = []

func _on_a_button_up() -> void:
	if not Global.a_active: return
	if exit_active:
		exit_index = 1 - exit_index
		move_arrow()

func _on_b_button_up() -> void:
	if not Global.b_active: return
	if exit_active:
		print("Selected: ", exit_index)
		if exit_index == 0:
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
			get_tree().quit()
		else: if exit_index == 1:
			deactivate_exit()
			main.activate_main()

func exit_menu() -> void:
	exit_layer.show()
	exit_active = true
	Global.a_active = true
	Global.b_active = true
	Global.c_active = false
	exit_index = 0
	exit_items = [yes_label, no_label]
func deactivate_exit() -> void:
	exit_layer.hide()
	exit_active = false
	Global.a_active = false
	Global.b_active = false
	Global.c_active = false

func move_arrow() -> void:
	var target := exit_items[exit_index] as Control
	arrow_label.global_position.y = target.global_position.y + target.size.y / 2 - arrow_label.size.y / 2
