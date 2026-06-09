extends Node2D

@onready var tama_controller: Node2D = get_node("/root/TamaGoonchii/TamaController")
@onready var tama_sprite: AnimatedSprite2D = get_node("/root/TamaGoonchii/Screen/TamaSprite")
@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var play_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Play")

var play_active: bool = false
var awaiting_guess: bool = false
var direction: int = 0
var guess: int = 0

func _on_a_button_up() -> void:
	if not Global.a_active: return
	if play_active && awaiting_guess:
		guess = 1

func _on_b_button_up() -> void:
	if not Global.b_active: return
	if play_active && awaiting_guess:
		guess = 2

func _on_c_button_up() -> void:
	if play_active:
		deactivate_play()
		main.activate_main()

func play_guess():
	for n in range(15):
		tama_sprite.play("playguess")
		direction = randi_range(0,1)
		awaiting_guess = true
		if direction == 1:
			tama_sprite.play("guessL")
		elif direction == 2:
			tama_sprite.play("guessR")
		if guess == direction:
				tama_sprite.play("correct")
		else:
			tama_sprite.play("wrong")

func play() -> void:
	play_layer.show()
	tama_sprite.show()
	play_active = true
	awaiting_guess = false
	Global.a_active = true
	Global.b_active = true
	Global.c_active = true
	play_guess()
func deactivate_play() -> void:
	play_layer.hide()
	play_active = false
	Global.a_active = false
	Global.b_active = false
	Global.c_active = false
