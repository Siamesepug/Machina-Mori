extends Node2D

# MAKE THIS A LIST TO INCLUDE ALL ENEMY TYPES
@export var enemy_type = load("res://scenes/objects/basic_flyer.tscn")
@export var spawn_radius = 800.0 # Space away from player to spawn

var current_wave = 1
var enemies_to_spawn = 15
var spawn_mult = (current_wave * 1.25)
var spawn_interval = 0.5 # seconds between spawns
var wave_delay = 60.0 # seconds between waves

@onready var spawn_timer = $SpawnTimer
@onready var wave_timer = $WaveTimer
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _ready():
	spawn_wave()

func spawn_wave():
	spawn_mult = (current_wave * 1.25)
	
	enemies_to_spawn = int(20 * spawn_mult)
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
	var enemy = enemy_type.instantiate()
	var spawn_pos = get_random_spawn_position()
	enemy.position = spawn_pos
	$"..".add_child(enemy)

func get_random_spawn_position():
	var player_pos = player.global_position
	var angle = randf() * 2.0 * PI
	var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
	return player_pos + offset
