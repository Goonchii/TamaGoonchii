extends Node2D

@onready var tama_controller: Node2D = get_node("/root/TamaGoonchii/TamaController")
@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var feed_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/FeedMenu")

@onready var arrow_label: Label = get_node("/root/TamaGoonchii/Screen/FeedMenu/Arrow")
@onready var meal_label: Label = get_node("/root/TamaGoonchii/Screen/FeedMenu/VBoxContainer/Meal")
@onready var snack_label: Label = get_node("/root/TamaGoonchii/Screen/FeedMenu/VBoxContainer/Snack")

var feed_active: bool = false
var feed_index: int = 0
var feed_items: Array[Label] = []

func _on_a_button_up() -> void:
	if not Global.a_active: return
	if feed_active:
		feed_index = 1 - feed_index
		move_arrow()

func _on_b_button_up() -> void:
	if not Global.b_active: return
	if feed_active:
		print("Selected: ", feed_index)
		if feed_index == 0:
			print("Feeding meal")
			deactivate_feed()
			main.activate_main()
			tama_controller.feed_meal(3)
		else: if feed_index == 1:
			print("Feeding snack")
			deactivate_feed()
			main.activate_main()
			tama_controller.feed_snack(1)

func _on_c_button_up() -> void:
	if feed_active:
		deactivate_feed()
		main.activate_main()

func feed_menu() -> void:
	feed_layer.show()
	feed_active = true
	feed_items = [meal_label, snack_label]
	feed_index = 0
	move_arrow()
	await get_tree().process_frame
	Global.a_active = true
	Global.b_active = true
	Global.c_active = true
func deactivate_feed() -> void:
	feed_layer.hide()
	feed_active = false
	Global.a_active = false
	Global.b_active = false
	Global.c_active = false

func move_arrow() -> void:
	var target := feed_items[feed_index] as Control
	arrow_label.global_position.y = target.global_position.y + target.size.y / 2 - arrow_label.size.y / 2
