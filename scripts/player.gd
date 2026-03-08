extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var sword_attack = $SwordAttack
@onready var dash_attack = $DashAttack
@onready var camera = $Camera2D

@export var air_resistance = 10.0 # lower means more floating in the air
@export var friction = 50.0 # how snappy the turning and stopping is on the ground
@export var screenshake_intensity = 50.0

var death_screen_resource = load("res://scenes/menus/death_screen.tscn")
var death_screen_instance = death_screen_resource.instantiate()

var current_weapon = PlayerAttributes.current_weapon
var weapon_damage = PlayerAttributes.weapon_damage
var weapon_cd = PlayerAttributes.weapon_cd
var on_weapon_cd = false
var weapon_size = PlayerAttributes.weapon_size

var dash_damage = PlayerAttributes.dash_damage
var dash_cd = PlayerAttributes.dash_cd
var dash_size = PlayerAttributes.dash_size

var current_health = PlayerAttributes.current_health
var max_health = PlayerAttributes.max_health

var xp_level = PlayerAttributes.xp_level
var xp_progress = PlayerAttributes.xp_progress
var xp_gain = PlayerAttributes.xp_gain

var dash_speed = PlayerAttributes.default_speed
var is_dashing = false
var speed = PlayerAttributes.speed
var jump_velocity = PlayerAttributes.jump_velocity

var max_jumps = PlayerAttributes.max_jumps
var jump_count = 0
var jump_cutoff_value = 0.4

var activate_screenshake = false
var shake_amount : float

func _ready():
	SignalManager.damage_player.connect(_take_damage)
	
	await get_tree().create_timer(0.5).timeout
	current_health = max_health
	SignalManager.hp_changed.emit()

func _process(delta):
	get_attributes()

func _physics_process(delta):
	
	# Add animation
	if velocity.x > 1 or velocity.x < -1:
		player_sprite.animation = "run"
	else:
		player_sprite.animation = "idle"
	
	# Check for screenshake based on velocity
	if not activate_screenshake:
		if velocity.y > 1000 || (velocity.x > 1500 || velocity.x < -1500):
			activate_screenshake = true
			shake_amount = 0.6
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_sprite.animation = "jump"
	else:
		# Reset total used jumps for multi-jumps
		jump_count = 0
	
	if is_on_floor() || is_on_wall():
		if activate_screenshake:
			activate_screenshake = false
			_screenshake()

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if jump_count < max_jumps:
			player_jump()
	
	if Input.is_action_just_released("jump"):
		# decrease jump velocity
		if !is_on_floor():
			velocity.y *= jump_cutoff_value
	
	if Input.is_action_just_pressed("debug_level_up"):
		PlayerAttributes.xp_progress += xp_gain
		SignalManager.xp_gained.emit(xp_gain)
	
	if Input.is_action_just_pressed("back"):
		get_tree().quit()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed * dash_speed
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, friction)
			activate_screenshake = false
		else:
			velocity.x = move_toward(velocity.x, 0, air_resistance)
	
	check_oneway_platform()
	
	move_and_slide()

	if direction == 1.0:
		sword_attack.global_position.x = global_position.x + (50 * direction)
		dash_attack.global_position.x = global_position.x + (50 * direction)
		player_sprite.flip_h = false
	elif direction == -1.0:
		sword_attack.global_position.x = global_position.x + (50 * direction)
		dash_attack.global_position.x = global_position.x + (50 * direction)
		player_sprite.flip_h = true
	
	# Fall death
	if position.y > 900:
		get_tree().current_scene.add_child(death_screen_instance)

func _input(event):
	
	# Attack input
	if Input.is_action_just_pressed("attack"):
		if current_weapon == "sword":
			if !on_weapon_cd:
				on_weapon_cd = true
				
				sword_attack.swing_sword()
				await get_tree().create_timer(weapon_cd).timeout
				
				print("Sword is restored")
				on_weapon_cd = false
	
	# Dash input
	if Input.is_action_just_pressed("dash"):
		if !is_dashing:
			is_dashing = true
			
			dash_attack.is_dashing()
			dash_speed = PlayerAttributes.dash_speed
			# LENGTH OF DASH, MIGHT MAKE VARIABLE
			await get_tree().create_timer(0.1).timeout
			_slow_from_dash()
			await get_tree().create_timer(dash_cd).timeout
			
			is_dashing = false

func player_jump():
	velocity.y = jump_velocity
	jump_sound.play()
	jump_count += 1

func check_oneway_platform():
	if Input.is_action_just_pressed("down") and is_on_floor():
		set_collision_mask_value(4, false)
		await get_tree().create_timer(0.1).timeout
		set_collision_mask_value(4, true)

func _slow_from_dash():
	
	# Gradual slow from dash, not instant back to normal speed
	if dash_speed > PlayerAttributes.default_speed:
		dash_speed -= 0.5
		await get_tree().create_timer(0.1).timeout
		_slow_from_dash()
	else:
		dash_speed = PlayerAttributes.default_speed
		return

func _take_damage(damage):
	PlayerAttributes.current_health -= damage
	damage_shader()
	current_health = PlayerAttributes.current_health
	
	SignalManager.hp_changed.emit()
	_is_dead()

func damage_shader():
	player_sprite.material.set_shader_parameter("intensity", 1.0)
	camera.shake_amount(0.3)
	await get_tree().create_timer(0.5).timeout
	
	player_sprite.material.set_shader_parameter("intensity", 0.0)

func _screenshake():
	camera.shake_amount(shake_amount)

func _is_dead():
	if current_health <= 0.0:
		get_tree().current_scene.add_child(death_screen_instance)
		get_tree().paused = true

func get_attributes():
	# Update all player stats with any new changes
	current_weapon = PlayerAttributes.current_weapon
	weapon_damage = PlayerAttributes.weapon_damage
	weapon_cd = PlayerAttributes.weapon_cd
	weapon_size = PlayerAttributes.weapon_size
	
	dash_damage = PlayerAttributes.dash_damage
	dash_cd = PlayerAttributes.dash_cd
	dash_size = PlayerAttributes.dash_size
	
	current_health = PlayerAttributes.current_health
	max_health = PlayerAttributes.max_health
	
	xp_level = PlayerAttributes.xp_level
	xp_progress = PlayerAttributes.xp_progress
	xp_gain = PlayerAttributes.xp_gain
	
	speed = PlayerAttributes.speed
	jump_velocity = PlayerAttributes.jump_velocity
	
	max_jumps = PlayerAttributes.max_jumps
	
	SignalManager.hp_changed.emit()
