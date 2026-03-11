extends Timer

@onready var main = $"../Levels"
@onready var starting_level = $"../Levels/LevelRoot"
@onready var lvl02 = load("res://scenes/levels/level02V2.tscn")

@onready var player = $"../Player"
@onready var level_transition_screen = $"../LevelTransition/TextureRect"

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
		main.add_child(lvl02.instantiate())
		_teleport_player(lvl02)

func _teleport_player(lvl):
	if lvl == lvl02:
		player.global_position.x = 0.0
		player.global_position.y = -1500.0

func _level_transition_shader():
	var tween = create_tween()
	
	tween.tween_property(level_transition_screen.material, "shader_parameter/progress", 1.0, 2.0)
	
	tween.tween_interval(0.5)
	
	tween.tween_property(level_transition_screen.material, "shader_parameter/progress", 0.0, 1.0)
