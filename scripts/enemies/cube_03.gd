extends CharacterBody2D

enum State {
	HUNT,
	CHARGE,
	FIRE,
	KNOCKBACK,
	COOLDOWN,
	DEAD
}

var state: State = State.HUNT
var state_start = false

var projectile_scene = load("res://scenes/objects/projectile.tscn")

var speed = EnemyStats.cube_speed
var damage = EnemyStats.cube_damage
var damage_cd = EnemyStats.cube_damage_cd

var current_health = EnemyStats.cube_max_health
var child_max_spawns = EnemyStats.cube_child_max_spawns

var charge_chance = EnemyStats.cube_charge_chance
var fire_chance = EnemyStats.cube_fire_chance

var can_damage = true # Is able to attack player (not on damage_cd)
var is_knocked_back = false
var is_jumping = false

var is_on_fire = false
var fire_stacks = 0

var is_on_frost = false
var frost_stacks = 0

var is_on_acid = false
var acid_stacks = 0

var is_on_electric = false
var electric_stacks = 0

var is_on_bleed = false
var bleed_stacks = 0

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var xp_drop = load("res://scenes/objects/xp_drop.tscn")
@onready var hurt_audio = $HurtAudio
@onready var health_bar = $HealthBar
@onready var sprite = $AnimatedSprite2D
@onready var charge_time = $ChargeTime
@onready var cooldown_timer = $CooldownTimer
@onready var death_audio = $DeathAudio
@onready var child_scene = load("res://scenes/objects/cube_child.tscn")

func _ready():
	health_bar.max_value = current_health
	health_bar.value = current_health
	SignalManager.level_change.connect(destroy)

func _physics_process(delta):
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
		return
	
	if current_health <= 0:
		state = State.DEAD
	
	match state:
		State.HUNT: # Decide if enemy should charge/fire
			state_start = false
			hunt_player(delta)
		State.CHARGE:
			if !state_start:
				state_start = true
				charge_player()
			move_and_slide()
		State.FIRE:
			if !state_start:
				state_start = true
				fire_at_player()
			
		State.KNOCKBACK:
			move_and_slide()
		State.COOLDOWN:
			if cooldown_timer.is_stopped():
				cooldown_timer.start()
			hunt_player(delta)
		State.DEAD:
			velocity += get_gravity() * delta
			move_and_slide()
			
			cooldown_timer.stop()
			charge_time.stop()
			health_bar.visible = false
			
			return

func hunt_player(delta):
	nav_agent.target_position = player.global_position
	
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	
	velocity = direction * speed
	
	move_and_slide()
	
	# decide what attack to use
	if !state_start:
		if global_position.distance_to(player.global_position) < 450:
			var attack_weight = charge_chance + fire_chance
			var roll = randf() * attack_weight
			
			if roll < charge_chance:
				state = State.CHARGE
			else:
				state = State.FIRE

func charge_player():
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed * 2
	
	charge_time.start()

func _on_charge_time_timeout():
	velocity = Vector2.ZERO
	state = State.COOLDOWN

func fire_at_player():
	velocity = Vector2.ZERO
	
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = global_position
	projectile.damage = damage
	
	var direction = global_position.direction_to(player.global_position)
	projectile.direction = direction
	
	await get_tree().create_timer(0.5).timeout
	
	state = State.COOLDOWN

func _on_cooldown_timer_timeout():
	state = State.HUNT

func _on_area_2d_body_entered(body: CharacterBody2D):
	await get_tree().create_timer(1.0).timeout
	
	if body == player && can_damage && (global_position.distance_to(player.global_position) < 90):
		SignalManager.damage_player.emit(damage)
		can_damage = false
		is_knocked_back = true
		
		var knockback_direction = player.global_position.direction_to(global_position)
		velocity = knockback_direction * (speed * 3)
		
		# Get knocked backwards from player after landing a hit
		await get_tree().create_timer(0.2).timeout
		is_knocked_back = false
		
		# Regain the ability to attack after a short cd
		await get_tree().create_timer(damage_cd).timeout
		can_damage = true

func take_damage(damage):
	current_health -= damage
	hurt_audio.play()
	
	health_bar.value = current_health
	
	take_knockback()
	
	is_dead()

func take_knockback():
	is_knocked_back = true
	state = State.KNOCKBACK
	
	await get_tree().create_timer(0.5).timeout
	
	state = State.HUNT
	is_knocked_back = false

func is_dead():
	if current_health <= 0:
		death_audio.play()
		state = State.DEAD
		await death_audio.finished
		
		visible = false
		
		for i in randi_range((child_max_spawns - 2), child_max_spawns):
			var cube_child = child_scene.instantiate()
			get_parent().add_child(cube_child)
			cube_child.global_position = global_position
			await get_tree().create_timer(0.05).timeout
		queue_free()

func on_fire(stacks: int, fire_damage: float):
	sprite.modulate = Color.RED
	if is_on_fire:
		fire_stacks += stacks
		return # already on fire, just increase the stacks
	
	is_on_fire = true
	fire_stacks = stacks
	print(fire_stacks)
	
	for count in range(fire_stacks): # Deal one tick of damage per interval of fire damage, until all fire stacks are gone
		current_health -= fire_damage
		health_bar.value = current_health
		fire_stacks -= 1
		is_dead()
		
		await get_tree().create_timer(Elements.fire_decay).timeout
	is_on_fire = false
	sprite.modulate = Color.WHITE

func on_frost(stacks: int, frost_damage: float, slow_duration: float):
	sprite.modulate = Color.DEEP_SKY_BLUE
	if is_on_frost:
		frost_stacks += stacks
		return # already on frost, just increase the stacks
	
	is_on_frost = true
	frost_stacks = stacks
	
	var temp_speed = speed
	speed = speed / 3
	await get_tree().create_timer(slow_duration).timeout
	speed = temp_speed * 0.75
	
	for count in range(frost_stacks): # Deal one tick of damage per interval of frost damage, until all frost stacks are gone
		current_health -= frost_damage
		health_bar.value = current_health
		frost_stacks -= 1
		is_dead()
		
		await get_tree().create_timer(Elements.frost_decay).timeout
	is_on_frost = false
	sprite.modulate = Color.WHITE

func on_acid(stacks: int, acid_damage: float):
	sprite.modulate = Color.GREEN
	if is_on_acid:
		acid_stacks += stacks
		return # already on acid, just increase the stacks
	
	is_on_acid = true
	acid_stacks = stacks
	print(acid_stacks)
	
	for count in range(acid_stacks): # Deal one tick of damage per interval of acid damage, until all acid stacks are gone
		current_health -= acid_damage
		health_bar.value = current_health
		acid_stacks -= 1
		is_dead()
		
		await get_tree().create_timer(Elements.acid_decay).timeout
	is_on_acid = false
	sprite.modulate = Color.WHITE

func on_electric(stacks: int, electric_damage: float, stun_duration: float):
	sprite.modulate = Color.DARK_BLUE
	if is_on_electric:
		electric_stacks += stacks
		return # already on electric, just increase the stacks
	
	is_on_electric = true
	electric_stacks = stacks
	
	var temp_speed = speed
	speed = 0
	await get_tree().create_timer(stun_duration).timeout
	speed = temp_speed
	
	for count in range(electric_stacks): # Deal one tick of damage per interval of electric damage, until all electric stacks are gone
		current_health -= electric_damage
		health_bar.value = current_health
		electric_stacks -= 1
		is_dead()
		
		await get_tree().create_timer(Elements.electric_decay).timeout
	is_on_electric = false
	sprite.modulate = Color.WHITE

func destroy(): # destroy enemy when level changes
	queue_free()
