extends CharacterComponent

const SPEED = 100.0
const JUMP_VELOCITY = 200.0

func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = -JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	player.move_and_slide()
