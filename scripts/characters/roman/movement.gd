extends CharacterComponent

const SPEED := 60.0
const RUN_MULTIPLIER := 2.0
const JUMP_VELOCITY := 300.0
const ACCELERATION := 800.0
const FRICTION := 600.0

func _physics_process(delta: float) -> void:
	apply_gravity(delta)

	var direction := Input.get_axis("player_left", "player_right")
	var isRunning := Input.is_action_pressed("player_run")
	var isJumping := Input.is_action_just_pressed("player_jump")

	move(delta, direction, isRunning)
	jump(isJumping)

	character.move_and_slide()

func apply_gravity(delta: float) -> void:
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta

func jump(isJumping: bool) -> void:
	if isJumping and character.is_on_floor():
		character.velocity.y = -JUMP_VELOCITY

func move(delta: float, direction: float, isRunning: bool):
	var speed := SPEED * (RUN_MULTIPLIER if isRunning else 1.0)

	if direction:
		character.velocity.x = move_toward(character.velocity.x, direction * speed, ACCELERATION * delta)

	else:
		if character.is_on_floor():
			character.velocity.x = move_toward(character.velocity.x, 0, FRICTION * delta)
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, (FRICTION * 0.1) * delta)

	if character.is_on_floor():
		var is_moving_physically = abs(character.velocity.x) > 0.1
		
		if graphics.animation == "jump_start" or graphics.animation == "jump_end":
			if graphics.animation == "jump_start":
				graphics.play("jump_end")
			
			if graphics.animation == "jump_end" and graphics.frame == graphics.sprite_frames.get_frame_count("jump_end") - 1:
				graphics.animation = "idle"

		elif not is_moving_physically:
			graphics.animation = "idle"

		else:
			graphics.animation = "run" if isRunning else "walk"

	else:
		if character.velocity.y < 0:
			graphics.animation = "jump_start"

	if direction > 0:
		graphics.flip_h = false
	elif direction < 0:
		graphics.flip_h = true
