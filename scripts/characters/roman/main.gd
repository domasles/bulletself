extends CharacterBody2D

@export var components: Array[Script] = []

func _ready() -> void:
	for component_script in components:
		if component_script:
			var component_instance = component_script.new()
			add_child(component_instance)

func initialize_script(script: Resource, nodeName: String) -> void:
	var scriptNode := Node.new()

	scriptNode.set_script(script)
	scriptNode.name = nodeName

	add_child(scriptNode)
