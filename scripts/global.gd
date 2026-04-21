extends Node

@onready var exit_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Exit")
@onready var feed_menu: CanvasGroup = get_node("/root/TamaGoonchii/Screen/FeedMenu")

var a_active: bool = false
var b_active: bool = false
var c_active: bool = false

func hide_layers() -> void:
	exit_layer.hide()
	feed_menu.hide()
