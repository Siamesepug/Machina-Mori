extends Timer

@onready var main = $"../Levels"
@onready var starting_level = $"../Levels/LevelRoot"
@onready var lvl02 = load("res://scenes/levels/level02V2.tscn")
@onready var lvl03 = load("res://scenes/levels/level03.tscn")
@onready var lvl04 = load("res://scenes/levels/level04.tscn")

var lvl02_instance = null
var lvl03_instance = null
var lvl04_instance = null

@onready var player = $"../Player"
@onready var level_transition_screen = $"../LevelTransition/TextureRect"
@onready var transition_audio = $"../LevelTransition/TransitionAudio"

@onready var wave_spawner = $"../WaveSpawner"
@onready var crawler = load("res://scenes/objects/crawler.tscn")
@onready var wireball = load("res://scenes/objects/wireball.tscn")
@onready var cube01 = load("res://scenes/objects/cube_01.tscn")
@onready var cube02 = load("res://scenes/objects/cube_02.tscn")
@onready var cube03 = load("res://scenes/objects/cube_03.tscn")

var level_duration = PlayerAttributes.level_duration # seconds before levels change

func _ready():
	wait_time = (level_duration)
	
	
func _process(delta):
	SignalManager.time_left.emit(time_left)

func _on_timeout() -> void:
	_level_transition_shader()
	
	await get_tree().create_timer(2.0).timeout
	
	SignalManager.clear_xp_orbs.emit()
	SignalManager.level_change.emit()
	
	if starting_level != null && starting_level.visible:
		starting_level.queue_free()
		lvl02_instance = lvl02.instantiate()
		main.add_child(lvl02_instance)
		_teleport_player(lvl02)
	elif lvl02_instance != null:
		lvl02_instance.queue_free()
		lvl03_instance = lvl03.instantiate()
		main.add_child(lvl03.instantiate())
		_teleport_player(lvl03)
	elif lvl03_instance != null:
		lvl03_instance.queue_free()
		lvl04_instance = lvl04.instantiate()
		main.add_child(lvl04.instantiate())
		_teleport_player(lvl04)

func _teleport_player(lvl):
	if lvl == lvl02:
		player.global_position.x = 0.0
		player.global_position.y = -1500.0
		wave_spawner.enemy_list.append(crawler) # add new enemy
	
	elif lvl == lvl03:
		player.global_position.x = 9.0
		player.global_position.y = -2855.0
		wave_spawner.enemy_list.append(wireball) # add new enemy
	
	elif lvl == lvl04:
		player.global_position.x = -120.0
		player.global_position.y = -2161.0
		wave_spawner.enemy_list.append(cube01) # add new enemy
		wave_spawner.enemy_list.append(cube02)
		wave_spawner.enemy_list.append(cube03)

func _level_transition_shader():
	transition_audio.play()
	var tween = create_tween()
	
	tween.tween_property(level_transition_screen.material, "shader_parameter/progress", 1.0, 2.0)
	
	tween.tween_interval(0.5)
	
	tween.tween_property(level_transition_screen.material, "shader_parameter/progress", 0.0, 1.0)
