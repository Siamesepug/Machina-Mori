extends Node2D

# MAKE THIS A LIST TO INCLUDE ALL ENEMY TYPES
#@export var enemy_type = load("res://scenes/objects/basic_flyer.tscn")
@export var enemy_list : Array[PackedScene] = []
@export var spawn_radius = 1600.0 # Space away from player to spawn

var current_wave = 1
var base_enemies = EnemyStats.enemies_to_spawn # num of enemies to scale off of
var enemies_to_spawn = base_enemies # the actual number to spawn after scaling
var spawn_mult = pow(EnemyStats.spawn_mult, current_wave)
var wave_delay = EnemyStats.wave_delay # seconds between waves
var spawn_interval = (wave_delay - 10.0) / enemies_to_spawn # seconds between spawns

@onready var spawn_timer = $SpawnTimer
@onready var wave_timer = $WaveTimer
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _ready():
	spawn_wave()

func spawn_wave():
	spawn_mult = pow(EnemyStats.spawn_mult, current_wave)
	enemies_to_spawn = int(base_enemies * spawn_mult)
	spawn_interval = (wave_delay - 10.0) / enemies_to_spawn
	
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()
	wave_timer.start(wave_delay)

func _on_spawn_timer_timeout():
	if enemies_to_spawn > 0:
		spawn_enemy()
		enemies_to_spawn -= 1
	else:
		spawn_timer.stop()

func _on_wave_timer_timeout():
	current_wave += 1
	level_up_enemy_stats()
	spawn_wave()

func level_up_enemy_stats():
	EnemyStats.flyer_damage += 2
	EnemyStats.flyer_speed += 10
	EnemyStats.flyer_max_health += 10
	
	EnemyStats.grunt_damage += 2
	EnemyStats.grunt_speed += 10
	EnemyStats.grunt_max_health += 10

func spawn_enemy():
	# chooses a random enemy to spawn from the given enemy list
	var enemy = enemy_list.pick_random().instantiate()
	var spawn_pos = get_random_spawn_position()
	enemy.global_position = spawn_pos
	get_parent().add_child(enemy)

func get_random_spawn_position():
	var player_pos = player.global_position
	var angle = randf() * 2.0 * PI
	var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
	var random_point = player_pos + offset
	
	var nav_map = get_world_2d().navigation_map
	var safe_point = NavigationServer2D.map_get_closest_point(nav_map, random_point)
	
	return safe_point
