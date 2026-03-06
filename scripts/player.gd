extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound

var xp_level = PlayerAttributes.xp_level
var xp_progress = PlayerAttributes.xp_progress

var dash_speed = PlayerAttributes.default_speed
var is_dashing = false
var speed = PlayerAttributes.speed
var jump_velocity = PlayerAttributes.jump_velocity

var max_jumps = PlayerAttributes.max_jumps
var jump_count = 0

func _process(delta):
	get_attributes()

func _physics_process(delta):
	
	# Add animation
	if velocity.x > 1 or velocity.x < -1:
		player_sprite.animation = "run"
	else:
		player_sprite.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_sprite.animation = "jump"
	else:
		# Reset total used jumps for multi-jumps
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if jump_count < max_jumps:
			player_jump()
	
	if Input.is_action_just_pressed("debug_level_up"):
		level_up()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed * dash_speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	if direction == 1.0:
		player_sprite.flip_h = false
	elif direction == -1.0:
		player_sprite.flip_h = true
	
	# Fall death
	if position.y > 720:
		get_tree().quit()

func _input(event):
	
	# Dash input
	if Input.is_action_just_pressed("dash"):
		if !is_dashing:
			is_dashing = true
			print("DASHING")
			
			dash_speed = PlayerAttributes.dash_speed
			await get_tree().create_timer(0.2).timeout
			dash_speed = PlayerAttributes.default_speed
			await get_tree().create_timer(1.0).timeout
			
			print("Dash is restored")
			is_dashing = false

func player_jump():
	velocity.y = jump_velocity
	jump_sound.play()
	jump_count += 1

func level_up():
	SignalManager.level_up.emit()
	PlayerAttributes.xp_level += 1
	print("Current Level: " + str(PlayerAttributes.xp_level))

func get_attributes():
	# Update all player stats with any new changes
	xp_level = PlayerAttributes.xp_level
	xp_progress = PlayerAttributes.xp_progress
	
	speed = PlayerAttributes.speed
	jump_velocity = PlayerAttributes.jump_velocity
	
	max_jumps = PlayerAttributes.max_jumps
