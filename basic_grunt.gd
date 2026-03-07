extends CharacterBody2D

# GOING TO HAVE A FEW MAIN STATES:
# - WANDERING
# - HUNTING
# - ATTACKING
# - DEAD

var state = "wandering"

var speed = EnemyStats.speed
var damage = EnemyStats.damage
var damage_cd = EnemyStats.damage_cd

var can_damage = true # Is able to attack player (not on damage_cd)
var is_knocked_back = false

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta):
	if player == null || is_knocked_back:
		print("UNABLE TO FIND PLAYER, TRYING AGAIN")
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
