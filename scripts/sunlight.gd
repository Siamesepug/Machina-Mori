extends DirectionalLight2D

@onready var level_timer = $"../LevelChangeTimer"
@onready var rotation_timer = $RotationTimer
@onready var level_duration = level_timer.level_duration

var start_rotation = -90.0
var end_rotation = 90.0

func _ready():
	start_cycle()

func start_cycle():
	rotation_degrees = start_rotation
	
	var tween = create_tween()
	
	tween.tween_property(self, "rotation_degrees", end_rotation, level_duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

func _on_level_change_timer_timeout():
	start_cycle()
