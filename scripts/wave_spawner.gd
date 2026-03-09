extends Node2D

# MAKE THIS A LIST TO INCLUDE ALL ENEMY TYPES
#@export var enemy_type = load("res://scenes/objects/basic_flyer.tscn")
@export var enemy_list : Array[PackedScene] = []
@export var spawn_radius = 1600.0 # Space away from player to spawn

var current_wave = 1
var enemies_to_spawn = EnemyStats.enemies_to_spawn
var spawn_mult = (current_wave * EnemyStats.spawn_mult)
var wave_delay = EnemyStats.wave_delay # seconds between waves
var spawn_interval = (wave_delay - 10.0) / enemies_to_spawn # seconds between spawns

@onready var spawn_timer = $SpawnTimer
@onready var wave_timer = $WaveTimer
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _ready():
	spawn_wave()

func spawn_wave():
	spawn_mult = (current_wave * 1.25)
	
	enemies_to_spawn = int(enemies_to_spawn * spawn_mult)
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if enemies_to_spawn > 0:
		spawn_enemy()
		enemies_to_spawn -= 1
	else:
		spawn_timer.stop()
		wave_timer.start(wave_delay)

func _on_wave_timer_timeout():
	current_wave += 1
	spawn_wave()

func spawn_enemy():
	# I know this line is awful and long, but hey it works
	# (it chooses a random enemy to spawn from the given enemy list)
	var enemy = enemy_list[(randi_range(0, (enemy_list.size() - 1)))].instantiate()
	var spawn_pos = get_random_spawn_position()
	enemy.position = spawn_pos
	get_parent().add_child(enemy)

func get_random_spawn_position():
	var player_pos = player.global_position
	var angle = randf() * 2.0 * PI
	var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
	var random_point = player_pos + offset
	
	var nav_map = get_world_2d().navigation_map
	var safe_point = NavigationServer2D.map_get_closest_point(nav_map, random_point)
	
	return safe_point
