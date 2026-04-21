extends Node

@onready var exit_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Exit")
@onready var feed_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/FeedMenu")
@onready var clean_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Clean")

var a_active: bool = false
var b_active: bool = false
var c_active: bool = false

# TODO: Add save + load

func hide_layers() -> void:
	exit_layer.hide()
	feed_layer.hide()
	clean_layer.hide()
