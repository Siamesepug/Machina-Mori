extends Control

@onready var standard_modes = $HBoxContainer/StandardModes
@onready var extra_modes = $HBoxContainer/ExtraModes

@onready var background = $TextureRect
@onready var black_screen = $BlackScreen

func _ready():
	standard_modes.visible = true
	extra_modes.visible = false

func _process(delta):
	background.rotation += 0.5 * delta

func _on_mode_button_pressed(mode):
	
	match mode:
		"marathon":
			set_marathon()
			play()
		"standard":
			set_standard()
			play()
		"blitz":
			set_blitz()
			play()
		"glass_cannon":
			set_glass_cannon()
			play()
		"chaos":
			set_chaos()
			play()
		"rip_and_tear":
			set_rip_and_tear()
			play()


func _on_extra_modes_button_pressed():
	standard_modes.visible = false
	extra_modes.visible = true


func _on_back_pressed():
	standard_modes.visible = true
	extra_modes.visible = false

func play():
	black_screen.modulate.a = 0.0
	black_screen.visible = true
	
	var tween = create_tween()
	tween.tween_property(black_screen, "modulate:a", 1.0, 1.0)
	await tween.finished
	await get_tree().create_timer(1.0).timeout
	
	#MainMenuMusic.stop()
	get_tree().change_scene_to_file("res://scenes/menus/loading_screen.tscn")

func set_marathon():
	PlayerAttributes.reset_to_base()
	
	# Change player stats
	PlayerAttributes.max_health = 200.0
	PlayerAttributes.current_health = 200.0
	PlayerAttributes.xp_gain = 5.0
	PlayerAttributes.level_duration = 900.0
	
	# Change enemy stats
	EnemyStats.enemies_to_spawn = 13
	EnemyStats.spawn_mult = 1.25
	EnemyStats.wave_delay = 100.0
	
	EnemyStats.flyer_max_health = 100.0
	EnemyStats.flyer_max_xp_drops = 3
	EnemyStats.flyer_speed = 200.0
	EnemyStats.flyer_damage = 10.0
	
	EnemyStats.grunt_max_health = 100.0
	EnemyStats.grunt_max_xp_drops = 3
	EnemyStats.grunt_speed = 300.0
	EnemyStats.grunt_damage = 10.0
	
	## CRAWLER STATS
	EnemyStats.crawler_speed = 200.0
	EnemyStats.crawler_damage = 20.0
	EnemyStats.crawler_max_health = 150.0
	EnemyStats.crawler_max_xp_drops = 3 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.wireball_speed = 50.0
	EnemyStats.wireball_damage = 15.0
	EnemyStats.wireball_max_health = 175.0
	EnemyStats.wireball_max_xp_drops = 5 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.cube_speed = 75.0
	EnemyStats.cube_damage = 20.0
	EnemyStats.cube_child_damage = 10.0
	EnemyStats.cube_max_health = 250.0
	EnemyStats.cube_child_max_health = 25.0
	EnemyStats.cube_max_xp_drops = 1 # max total xp drops per kill (for child only)
	EnemyStats.cube_child_max_spawns = 4 # max amount of cubes to spawn

func set_standard():
	PlayerAttributes.reset_to_base()
	
	# Change player stats
	PlayerAttributes.max_health = 100.0
	PlayerAttributes.current_health = 100.0
	PlayerAttributes.xp_gain = 10.0
	PlayerAttributes.level_duration = 300.0
	
	# Change enemy stats
	EnemyStats.enemies_to_spawn = 10
	EnemyStats.spawn_mult = 1.25
	EnemyStats.wave_delay = 60.0
	
	EnemyStats.flyer_max_health = 100.0
	EnemyStats.flyer_max_xp_drops = 3
	EnemyStats.flyer_speed = 200.0
	EnemyStats.flyer_damage = 10.0
	
	EnemyStats.grunt_max_health = 100.0
	EnemyStats.grunt_max_xp_drops = 3
	EnemyStats.grunt_speed = 300.0
	EnemyStats.grunt_damage = 10.0
	
	## CRAWLER STATS
	EnemyStats.crawler_speed = 200.0
	EnemyStats.crawler_damage = 20.0
	EnemyStats.crawler_max_health = 150.0
	EnemyStats.crawler_max_xp_drops = 3 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.wireball_speed = 50.0
	EnemyStats.wireball_damage = 15.0
	EnemyStats.wireball_max_health = 175.0
	EnemyStats.wireball_max_xp_drops = 5 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.cube_speed = 75.0
	EnemyStats.cube_damage = 20.0
	EnemyStats.cube_child_damage = 10.0
	EnemyStats.cube_max_health = 250.0
	EnemyStats.cube_child_max_health = 25.0
	EnemyStats.cube_max_xp_drops = 1 # max total xp drops per kill (for child only)
	EnemyStats.cube_child_max_spawns = 4 # max amount of cubes to spawn

func set_blitz():
	PlayerAttributes.reset_to_base()
	
	# Change player stats
	PlayerAttributes.max_health = 75.0
	PlayerAttributes.current_health = 75.0
	PlayerAttributes.xp_gain = 25.0
	PlayerAttributes.level_duration = 150.0
	
	# Change enemy stats
	EnemyStats.enemies_to_spawn = 8
	EnemyStats.spawn_mult = 1.25
	EnemyStats.wave_delay = 30.0
	
	EnemyStats.flyer_max_health = 100.0
	EnemyStats.flyer_max_xp_drops = 3
	EnemyStats.flyer_speed = 200.0
	EnemyStats.flyer_damage = 10.0
	
	EnemyStats.grunt_max_health = 100.0
	EnemyStats.grunt_max_xp_drops = 3
	EnemyStats.grunt_speed = 300.0
	EnemyStats.grunt_damage = 10.0
	
	## CRAWLER STATS
	EnemyStats.crawler_speed = 200.0
	EnemyStats.crawler_damage = 20.0
	EnemyStats.crawler_max_health = 150.0
	EnemyStats.crawler_max_xp_drops = 3 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.wireball_speed = 50.0
	EnemyStats.wireball_damage = 15.0
	EnemyStats.wireball_max_health = 175.0
	EnemyStats.wireball_max_xp_drops = 5 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.cube_speed = 75.0
	EnemyStats.cube_damage = 20.0
	EnemyStats.cube_child_damage = 10.0
	EnemyStats.cube_max_health = 250.0
	EnemyStats.cube_child_max_health = 25.0
	EnemyStats.cube_max_xp_drops = 1 # max total xp drops per kill (for child only)
	EnemyStats.cube_child_max_spawns = 4 # max amount of cubes to spawn

func set_glass_cannon():
	PlayerAttributes.reset_to_base()
	
	# Change player stats
	PlayerAttributes.max_health = 1.0
	PlayerAttributes.current_health = 1.0
	
	# Change enemy stats
	EnemyStats.enemies_to_spawn = 10
	EnemyStats.spawn_mult = 1.25
	EnemyStats.wave_delay = 60.0
	
	EnemyStats.flyer_max_health = 1.0
	EnemyStats.flyer_max_xp_drops = 3
	EnemyStats.flyer_speed = 200.0
	EnemyStats.flyer_damage = 10.0
	
	EnemyStats.grunt_max_health = 1.0
	EnemyStats.grunt_max_xp_drops = 3
	EnemyStats.grunt_speed = 300.0
	EnemyStats.grunt_damage = 10.0
	
	## CRAWLER STATS
	EnemyStats.crawler_speed = 200.0
	EnemyStats.crawler_damage = 20.0
	EnemyStats.crawler_max_health = 1.0
	EnemyStats.crawler_max_xp_drops = 3 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.wireball_speed = 50.0
	EnemyStats.wireball_damage = 15.0
	EnemyStats.wireball_max_health = 1.0
	EnemyStats.wireball_max_xp_drops = 5 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.cube_speed = 75.0
	EnemyStats.cube_damage = 20.0
	EnemyStats.cube_child_damage = 10.0
	EnemyStats.cube_max_health = 1.0
	EnemyStats.cube_child_max_health = 1.0
	EnemyStats.cube_max_xp_drops = 1 # max total xp drops per kill (for child only)
	EnemyStats.cube_child_max_spawns = 4 # max amount of cubes to spawn
	
	PlayerAttributes.glass_cannon = true

func set_chaos():
	PlayerAttributes.reset_to_base()
	
	# Change player stats
	PlayerAttributes.max_health = randi_range(1, 300)
	PlayerAttributes.current_health = randi_range(1, 300)
	PlayerAttributes.xp_gain = randi_range(1, 99)
	PlayerAttributes.level_duration = randi_range(100, 600)
	
	# Change enemy stats
	EnemyStats.enemies_to_spawn = randi_range(1, 60)
	EnemyStats.spawn_mult = randi_range(1, 1.75)
	EnemyStats.wave_delay = randi_range(15.0, 75.0)
	
	EnemyStats.flyer_max_health = randi_range(1, 500)
	EnemyStats.flyer_max_xp_drops = randi_range(1, 15)
	EnemyStats.flyer_speed = randi_range(100, 350)
	EnemyStats.flyer_damage = randi_range(1, 50)
	
	EnemyStats.grunt_max_health = randi_range(1, 500)
	EnemyStats.grunt_max_xp_drops = randi_range(1, 15)
	EnemyStats.grunt_speed = randi_range(100, 400)
	EnemyStats.grunt_damage = randi_range(1, 50)
	
	## CRAWLER STATS
	EnemyStats.crawler_speed = randi_range(100, 400)
	EnemyStats.crawler_damage = randi_range(1, 50)
	EnemyStats.crawler_max_health = randi_range(1, 500)
	EnemyStats.crawler_max_xp_drops = randi_range(1, 15)

	## WIREBALL STATS
	EnemyStats.wireball_speed = randi_range(100, 400)
	EnemyStats.wireball_damage = randi_range(1, 50)
	EnemyStats.wireball_max_health = randi_range(1, 500)
	EnemyStats.wireball_max_xp_drops = randi_range(1, 15)

	## WIREBALL STATS
	EnemyStats.cube_speed = randi_range(100, 400)
	EnemyStats.cube_damage = randi_range(1, 50)
	EnemyStats.cube_child_damage = randi_range(1, 50)
	EnemyStats.cube_max_health = randi_range(1, 500)
	EnemyStats.cube_child_max_health = randi_range(1, 500)
	EnemyStats.cube_max_xp_drops = randi_range(1, 15)
	EnemyStats.cube_child_max_spawns = randi_range(1, 15)

func set_rip_and_tear():
	PlayerAttributes.reset_to_base()
	
	# Change player stats
	PlayerAttributes.max_health = 1000.0
	PlayerAttributes.current_health = 1000.0
	PlayerAttributes.xp_gain = 1.0
	PlayerAttributes.level_duration = 300.0
	
	# Change enemy stats
	EnemyStats.enemies_to_spawn = 200
	EnemyStats.spawn_mult = 1.5
	EnemyStats.wave_delay = 60.0
	
	EnemyStats.flyer_max_health = 50.0
	EnemyStats.flyer_max_xp_drops = 1
	EnemyStats.flyer_speed = 200.0
	EnemyStats.flyer_damage = 1.0
	
	EnemyStats.grunt_max_health = 50.0
	EnemyStats.grunt_max_xp_drops = 1
	EnemyStats.grunt_speed = 300.0
	EnemyStats.grunt_damage = 1.0
	
	## CRAWLER STATS
	EnemyStats.crawler_speed = 200.0
	EnemyStats.crawler_damage = 1.0
	EnemyStats.crawler_max_health = 50.0
	EnemyStats.crawler_max_xp_drops = 3 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.wireball_speed = 50.0
	EnemyStats.wireball_damage = 1.0
	EnemyStats.wireball_max_health = 50.0
	EnemyStats.wireball_max_xp_drops = 5 # max total xp drops per kill

	## WIREBALL STATS
	EnemyStats.cube_speed = 75.0
	EnemyStats.cube_damage = 1.0
	EnemyStats.cube_child_damage = 10.0
	EnemyStats.cube_max_health = 50.0
	EnemyStats.cube_child_max_health = 25.0
	EnemyStats.cube_max_xp_drops = 1 # max total xp drops per kill (for child only)
	EnemyStats.cube_child_max_spawns = 4 # max amount of cubes to spawn

func _on_back_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")
