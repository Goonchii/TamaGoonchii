extends Node2D

@onready var tama_sprite: AnimatedSprite2D = $"../Screen/AnimatedSprite2D"

var hunger: int = 10
var dirtiness: int = 10
var boredom: int = 10

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
