extends CharacterBody2D

# GOING TO HAVE A FEW MAIN STATES:
# - WANDERING
# - HUNTING
# - ATTACKING
# - DEAD

var state = "wandering"

var speed = EnemyStats.grunt_speed
var damage = EnemyStats.grunt_damage
var damage_cd = EnemyStats.grunt_damage_cd

var current_health = EnemyStats.grunt_max_health

var max_xp_drops = EnemyStats.grunt_max_xp_drops

var can_damage = true # Is able to attack player (not on damage_cd)
var is_knocked_back = false
var is_jumping = false

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var xp_drop = load("res://scenes/objects/xp_drop.tscn")

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
	
	if !is_jumping:
		velocity += (get_gravity() * 3.5) * delta
	else:
		_jump(delta)
	
	
	
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


func _on_timer_timeout() -> void:
	if is_on_floor():
		is_jumping = true
		await get_tree().create_timer(0.1).timeout
		is_jumping = false

func _jump(delta):
	print("JUMPING NOW")
	velocity -= (get_gravity() * 5) * delta
	move_and_slide()

func take_damage(damage):
	current_health -= damage
	print("I TOOK DAMAGE : " + str(damage))
	
	if current_health <= 0:
		max_xp_drops = EnemyStats.grunt_max_xp_drops
		var xp_drops = randi_range(1, max_xp_drops)
		
		for orb in range(xp_drops):
			var xp_orb = xp_drop.instantiate()
			$"..".add_child(xp_orb)
			xp_orb.global_position = global_position
			queue_free()
