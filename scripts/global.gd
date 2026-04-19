extends Node

@onready var exit_layer: CanvasGroup = get_node("/root/TamaGoonchii/Screen/Exit")

var a_active: bool = false
var b_active: bool = false
var c_active: bool = false

func hide_layers() -> void:
	exit_layer.hide()
