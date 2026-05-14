extends Node
class_name CharacterComponent

var player: CharacterBody2D

func _ready() -> void:
	player = get_parent() as CharacterBody2D

	if not player:
		push_error("Component '" + name + "' must be a child of a CharacterBody2D!")
