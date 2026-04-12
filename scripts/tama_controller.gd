extends Node2D

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

func hunger_timeout() -> void:
	if randi_range(1,10) < 5:
		hunger -= 1
		print("Hunger is now : ", hunger)

func dirty_timeout() -> void:
	if randi_range(1,10) < 5:
		dirtiness -= 1
		print("Dirtiness is now : ", dirtiness)

func boredom_timeout() -> void:
	if randi_range(1,10) < 5:
		boredom -= 1
		print("Boredom is now : ", boredom)
