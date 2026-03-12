extends CharacterBody2D

# GOING TO HAVE A FEW MAIN STATES:
# - WANDERING
# - HUNTING
# - ATTACKING
# - DEAD

#var state = "wandering"

# Gonna need to do quite an overhaul here ngl
# Need to have ~2 states where the enemy shoots the player or charges
# at the player. This way, events can override the states and maybe even setup
# an adaptive system to see what states are working better than others.

var speed = EnemyStats.flyer_speed
var damage = EnemyStats.flyer_damage
var damage_cd = EnemyStats.flyer_damage_cd

var current_health = EnemyStats.flyer_max_health

var max_xp_drops = EnemyStats.flyer_max_xp_drops
var can_damage = true # Is able to attack player (not on damage_cd)
var is_knocked_back = false

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
@onready var sprite = $Sprite2D

func _ready():
	health_bar.max_value = current_health
	health_bar.value = current_health
	SignalManager.level_change.connect(destroy)

func _physics_process(delta):
	if player == null || is_knocked_back:
		player = get_tree().get_first_node_in_group("Player")
		
		# Still process movement for when knocked back, if needed
		move_and_slide()
		return
	
	nav_agent.target_position = player.global_position
	
	if nav_agent.is_navigation_finished():
		return
	
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	
	velocity = direction * speed
	
	move_and_slide()


func _on_area_2d_body_entered(body: CharacterBody2D):
	if body == player && can_damage:
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
	
	is_dead()

func is_dead():
	if current_health <= 0:
		max_xp_drops = EnemyStats.flyer_max_xp_drops
		var xp_drops = randi_range(1, max_xp_drops)
		
		for orb in range(xp_drops):
			var xp_orb = xp_drop.instantiate()
			$"..".add_child(xp_orb)
			xp_orb.global_position = global_position
			queue_free()

func on_fire(stacks: int, fire_damage: float):
	
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
		sprite.modulate = Color.RED
		is_dead()
		
		await get_tree().create_timer(Elements.fire_decay).timeout
	is_on_fire = false
	sprite.modulate = Color.WHITE

func on_frost(stacks: int, frost_damage: float, slow_duration: float):
	
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
		sprite.modulate = Color.DEEP_SKY_BLUE
		is_dead()
		
		await get_tree().create_timer(Elements.frost_decay).timeout
	is_on_frost = false
	sprite.modulate = Color.WHITE

func on_acid(stacks: int, acid_damage: float):
	
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
		sprite.modulate = Color.GREEN
		is_dead()
		
		await get_tree().create_timer(Elements.acid_decay).timeout
	is_on_acid = false
	sprite.modulate = Color.WHITE

func on_electric(stacks: int, electric_damage: float, stun_duration: float):
	
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
		sprite.modulate = Color.DARK_BLUE
		is_dead()
		
		await get_tree().create_timer(Elements.electric_decay).timeout
	is_on_electric = false
	sprite.modulate = Color.WHITE

func destroy(): # destroy enemy when level changes
	queue_free()
