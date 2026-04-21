extends Node2D

@onready var tama_controller: Node2D = get_node("/root/TamaGoonchii/TamaController")
@onready var tama_sprite: AnimatedSprite2D = get_node("/root/TamaGoonchii/Screen/TamaSprite")
@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var icons_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Icons")

@onready var clean_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Clean")

var clean_active: bool = false

func _on_b_button_up() -> void:
	if not Global.b_active: return
	if clean_active:
		tama_controller.is_cleaning = true
		tama_sprite.frame += 1
		print("frame advanced: ", tama_sprite.frame)
		if tama_sprite.frame == 4 :
			tama_sprite.play("rinse")

func _on_c_button_up() -> void:
	if clean_active:
		deactivate_clean()
		main.activate_main()
		tama_controller.update_animation()

func clean() -> void:
	tama_sprite.show()
	clean_active = true
	await get_tree().process_frame
	Global.a_active = false
	Global.b_active = true
	Global.c_active = true
	tama_sprite.play("clean")
	tama_sprite.pause()
func deactivate_clean() -> void:
	clean_layer.hide()
	clean_active = false
	Global.a_active = false
	Global.b_active = false
	Global.c_active = false
