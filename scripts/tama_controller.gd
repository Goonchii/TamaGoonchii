extends Node2D

@onready var tama_sprite: AnimatedSprite2D = get_node("/root/TamaGoonchii/Screen/TamaSprite")

@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var clean_control: Node2D = get_node("/root/TamaGoonchii/Screen/Clean/CleanControl")

var hunger: int = 10
var dirtiness: int = 10
var boredom: int = 10

const MIN_HUNGER = 0
const MAX_HUNGER = 10
var is_feeding: bool = false
var is_cleaning: bool = false

func _ready() -> void:
	print("Starting..")
	$HungerTimer.timeout.connect(hunger_timeout)
	$DirtyTimer.timeout.connect(dirty_timeout)
	$BoredomTimer.timeout.connect(boredom_timeout)
	# TODO: Move this later
	$HungerTimer.start()
	$DirtyTimer.start()
	$BoredomTimer.start()
	update_animation()

func update_animation() -> void:
	if is_feeding || is_cleaning: return
	if dirtiness < 4:
		tama_sprite.play("dirty")
	elif boredom < 4:
		tama_sprite.play("bored")
	elif hunger < 4:
		tama_sprite.play("hungry")
	else:
		tama_sprite.play("default")


func hunger_timeout() -> void:
	if randi_range(1,10) < 5 && hunger > 0:
		hunger -= 1
		print("Hunger is now : ", hunger)
		update_animation()

func dirty_timeout() -> void:
	if randi_range(1,10) < 5 && dirtiness > 0:
		dirtiness -= 1
		print("Dirtiness is now : ", dirtiness)
		update_animation()

func boredom_timeout() -> void:
	if randi_range(1,10) < 5 && boredom > 0:
		boredom -= 1
		print("Boredom is now : ", boredom)
		update_animation()


func feed_food(hunger_increase) -> void:
	is_feeding = true
	hunger = clamp(hunger + hunger_increase, MIN_HUNGER, MAX_HUNGER)
	tama_sprite.play("feedfood")
	print("Hunger is now : ", hunger)
func feed_drink(hunger_increase) -> void:
	is_feeding = true
	hunger = clamp(hunger + hunger_increase, MIN_HUNGER, MAX_HUNGER)
	tama_sprite.play("feeddrink")
	print("Hunger is now : ", hunger)

func _on_tama_sprite_animation_finished() -> void:
	var anim_name = tama_sprite.animation
	print("Anim finished :", anim_name)
	if anim_name in ["feedfood", "feeddrink"]:
		is_feeding = false
		update_animation()
	if anim_name in ["rinse"]:
		is_cleaning = false
		clean_control.deactivate_clean()
		main.activate_main()
		update_animation()
