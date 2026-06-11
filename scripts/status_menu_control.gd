extends Node2D

@onready var tama_controller: Node2D = get_node("/root/TamaGoonchii/TamaController")
@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var status_menu_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/StatusMenu")

@onready var status_label: Label = get_node("/root/TamaGoonchii/Screen/StatusMenu/VBoxContainer/StatusLabel")
@onready var age_label: Label = get_node("/root/TamaGoonchii/Screen/StatusMenu/VBoxContainer/HBoxContainer/AgeLabel")
@onready var happiness_label: Label = get_node("/root/TamaGoonchii/Screen/StatusMenu/VBoxContainer/HappinessLabel")

var status_visible: bool = false

func _on_c_button_up() -> void:
	if status_visible:
		deactivate_status_menu()
		main.activate_main()


func update_labels() -> void:
	status_label.text = str(tama_controller.status)
	age_label.text = str(tama_controller.age) + " yrs"
	happiness_label.text = str(tama_controller.happiness) + "/5 <3"


func status_menu() -> void:
	status_menu_layer.show()
	status_visible = true
	update_labels()
	Global.a_active = false
	Global.b_active = false
	Global.c_active = true
func deactivate_status_menu() -> void:
	status_menu_layer.hide()
	status_visible = false
	Global.a_active = false
	Global.b_active = false
	Global.c_active = false
