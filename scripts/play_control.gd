extends Node2D

@onready var tama_controller: Node2D = get_node("/root/TamaGoonchii/TamaController")
@onready var tama_sprite: AnimatedSprite2D = get_node("/root/TamaGoonchii/Screen/TamaSprite")
@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var play_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Play")

@onready var left_arrow: Label = get_node("/root/TamaGoonchii/Screen/Play/<")
@onready var right_arrow: Label = get_node("/root/TamaGoonchii/Screen/Play/>")

var play_active: bool = false
var awaiting_guess: bool = false
var turns: int = 0
var score: int = 0
var direction: String = ""
var guess: String = ""
signal guess_made(option: int)

func _on_a_button_up() -> void:
	if not Global.a_active: return
	if play_active && awaiting_guess:
		guess_made.emit("Left")
		right_arrow.hide()
		awaiting_guess = false

func _on_b_button_up() -> void:
	if not Global.b_active: return
	if play_active && awaiting_guess:
		guess_made.emit("Right")
		left_arrow.hide()
		awaiting_guess = false

func _on_c_button_up() -> void:
	if play_active:
		deactivate_play()
		main.activate_main()

func play_guess() -> void:
	tama_sprite.play("playguess")
	direction = ["Left","Right"].pick_random()
	print("Direction: ", direction)
	guess = await guess_made
	print("Guess: ", guess)
	if direction == "Left":
		tama_sprite.play("guessL")
	elif direction == "Right":
		tama_sprite.play("guessR")

func _on_tama_sprite_animation_finished() -> void:
	var anim_name = tama_sprite.animation
	
	if anim_name in ["guessL", "guessR"]:
		if guess == direction:
			tama_sprite.play("correct")
			score += 1
		else:
			tama_sprite.play("incorrect")
		turns += 1
		direction = ""
		guess = ""
		left_arrow.hide()
		right_arrow.hide()
		
	elif anim_name in ["correct", "incorrect"] && turns < 5:
		play_guess()
	elif anim_name in ["correct", "incorrect"] && turns == 5:
		tama_controller.play_end()
	elif anim_name in ["win", "lose"]:
		deactivate_play()
		main.activate_main()
	elif anim_name in ["playguess"]:
		awaiting_guess = true
		tama_sprite.play("default")
		left_arrow.show()
		right_arrow.show()

func play() -> void:
	play_layer.show()
	tama_sprite.show()
	play_active = true
	turns = 0
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
	tama_controller.update_animation()
