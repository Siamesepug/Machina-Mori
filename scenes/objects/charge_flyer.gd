extends CharacterBody2D

# GOING TO HAVE A FEW MAIN STATES:
# - WANDERING
# - HUNTING
# - ATTACKING
# - DEAD

#var state = "wandering"

# this one likes to charge at the player, not really shooting much

var speed = EnemyStats.flyer_speed
var damage = EnemyStats.flyer_damage
var damage_cd = EnemyStats.flyer_damage_cd

var current_health = EnemyStats.flyer_max_health

var max_xp_drops = EnemyStats.flyer_max_xp_drops
var can_damage = true # Is able to attack player (not on damage_cd)
var is_knocked_back = false

var is_on_fire = false
var fire_stacks = 0

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var xp_drop = load("res://scenes/objects/xp_drop.tscn")
@onready var hurt_audio = $HurtAudio
@onready var health_bar = $HealthBar

func _ready():
	health_bar.max_value = current_health
	health_bar.value = current_health

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
	print("ON FIRE!!!")
	#if is_on_fire:
	#	fire_stacks += stacks
	#	return # already on fire, just increase the stacks
	#
	#is_on_fire = true
	#for count in range(fire_stacks): # Deal one tick of damage per interval of fire damage, until all fire stacks are gone
	#	current_health -= fire_damage
	#	fire_stacks -= 1
	#	is_dead()
	#	
	#	await get_tree().create_timer(Elements.fire_decay).timeout
	#is_on_fire = false
