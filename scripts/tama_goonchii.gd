extends Node2D

var offset: Vector2 = Vector2.ZERO
var dragging: bool = false

func _ready() -> void:
	get_window().mouse_passthrough = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("RClick"):
		dragging = true
		offset = get_viewport().get_mouse_position()
	if Input.is_action_just_released("RClick"):
		dragging = false
		offset = Vector2.ZERO
	if dragging:
		var current_mouse_pos: Vector2 = DisplayServer.mouse_get_position()
		var window_pos: Vector2 = current_mouse_pos - offset
		DisplayServer.window_set_position(window_pos)
