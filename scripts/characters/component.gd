extends Node
class_name CharacterComponent

var character: CharacterBody2D
var graphics: AnimatedSprite2D

func _ready() -> void:
	character = get_parent() as CharacterBody2D
	graphics = character.get_node("AnimatedSprite2D") as AnimatedSprite2D

	if not character:
		push_error("Component '" + name + "' must be a child of a CharacterBody2D!")

	if not graphics:
		push_warning("Component '" + name + "' requires an AnimatedSprite2D node for proper usage.")
		graphics = null
