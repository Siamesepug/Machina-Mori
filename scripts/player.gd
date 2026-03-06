extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound


var dash_speed = PlayerAttributes.dash_speed
var speed = PlayerAttributes.speed
var jump_velocity = PlayerAttributes.jump_velocity

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

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jump_sound.play()

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
	var is_dashing = false
	
	# Dash input
	if Input.is_action_just_pressed("dash"):
		if !is_dashing:
			is_dashing = true
			print("DASHING")
			dash_speed = 4.0
			await get_tree().create_timer(0.2).timeout
			dash_speed = 1.0
			await get_tree().create_timer(1.0).timeout
			print("Dash is restored")
			is_dashing = false

func get_attributes():
	# Update all player stats with any new changes
	speed = PlayerAttributes.speed
	jump_velocity = PlayerAttributes.jump_velocity
	dash_speed = PlayerAttributes.dash_speed
