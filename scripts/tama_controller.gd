extends Node2D

@onready var tama_sprite: AnimatedSprite2D = get_node("/root/TamaGoonchii/Screen/TamaSprite")

@onready var main: Node2D = get_node("/root/TamaGoonchii/Screen/Icons/SelectControl")
@onready var clean_control: Node2D = get_node("/root/TamaGoonchii/Screen/Clean/CleanControl")
@onready var play_control: Node2D = get_node("/root/TamaGoonchii/Screen/Play/PlayControl")

var status: String = "Happy :D"
var age: int = 0
var happiness: int = 5

var hunger: int = 10
var dirtiness: int = 10
var boredom: int = 10
var poop: int = 0
var tired: int = 0
var sick: int = 0

const MIN_HUNGER = 0
const MAX_HUNGER = 10
const MIN_BOREDOM = 0
const MAX_BOREDOM = 10
var is_feeding: bool = false
var is_cleaning: bool = false
var is_clearing: bool = false
var is_playing: bool = false

func _ready() -> void:
	print("Starting..")
	$HungerTimer.timeout.connect(hunger_timeout)
	$DirtyTimer.timeout.connect(dirty_timeout)
	$BoredomTimer.timeout.connect(boredom_timeout)
	$PoopTimer.timeout.connect(poop_timeout)
	$SickTimer.timeout.connect(sick_timeout)
	$TiredTimer.timeout.connect(tired_timeout)
	# TODO: Move this later
	$HungerTimer.start()
	$DirtyTimer.start()
	$BoredomTimer.start()
	$PoopTimer.start()
	$SickTimer.start()
	$TiredTimer.start()
	update_animation()

func update_animation() -> void:
	if is_feeding || is_cleaning || is_clearing || play_control.play_active : return
	if sick == 5:
		tama_sprite.play("sick")
		status = "Sick o~o"
	elif tired > 8:
		tama_sprite.play("tired")
		status = "Tired u.u"
	elif poop == 1:
		tama_sprite.play("poop1")
		status = "Smelly :("
	elif poop == 2:
		tama_sprite.play("poop2")
		status = "Smelly :("
	elif dirtiness < 4:
		tama_sprite.play("dirty")
		status = "Dirty :("
	elif boredom < 4:
		tama_sprite.play("bored")
		status = "Bored :/"
	elif hunger < 4:
		tama_sprite.play("hungry")
		status = "Hungry :/"
	else:
		tama_sprite.play("default")
		status = "Happy :D"


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

func poop_timeout() -> void:
	if randi_range(1,10) < 5 && poop < 2:
		poop += 1
		print("Poop is now : ", poop)
		update_animation()

func sick_timeout() -> void:
	if randi_range(1,10) < 5 && sick < 5:
		sick += 1
		print("Sick is now: ", sick)
		update_animation()

func tired_timeout() -> void:
	if randi_range(1,10) < 5 && tired < 10:
		tired += 1
		print("Tired is now: ", tired)
		update_animation()

# TODO: ADD SLEEP AND MEDICINE

func feed_food(hunger_increase) -> void:
	is_feeding = true
	hunger = clamp(hunger + hunger_increase, MIN_HUNGER, MAX_HUNGER)
	tama_sprite.play("feedfood")
	print("Hunger is now: ", hunger)
func feed_drink(hunger_increase) -> void:
	is_feeding = true
	hunger = clamp(hunger + hunger_increase, MIN_HUNGER, MAX_HUNGER)
	tama_sprite.play("feeddrink")
	print("Hunger is now: ", hunger)

func clear_poop() -> void:
	is_clearing = true
	if poop == 1:
		tama_sprite.play("clear1")
		print("Playing ani")
	elif poop == 2:
		tama_sprite.play("clear2")
		print("Playing ani")
	else:
		is_clearing = false
	poop = 0
	print("Poop is now: ", poop)

func play_end() -> void:
	if play_control.score > 3:
		tama_sprite.play("win")
		boredom = clamp(boredom + play_control.score, MIN_BOREDOM, MAX_BOREDOM)
		print("Boredom: ", boredom)
	else:
		tama_sprite.play("lose")

func _on_tama_sprite_animation_finished() -> void:
	var anim_name = tama_sprite.animation
	print("Anim finished :", anim_name)
	if anim_name in ["feedfood", "feeddrink"]:
		is_feeding = false
		update_animation()
	if anim_name in ["rinse"]:
		is_cleaning = false
		clean_control.deactivate_clean()
		dirtiness = 10
		main.activate_main()
		update_animation()
	if anim_name in ["clear1", "clear2"]:
		is_clearing = false
		update_animation()
