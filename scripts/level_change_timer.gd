extends Timer

@onready var main = $"../Levels"
@onready var starting_level = $"../Levels/Level01"
@onready var lvl02 = load("res://scenes/levels/level02.tscn")

var level_duration = PlayerAttributes.level_duration # seconds before levels change

func _ready():
	wait_time = (level_duration)
	
	
func _process(delta):
	SignalManager.time_left.emit(time_left)

func _on_timeout() -> void:
	if starting_level != null && starting_level.visible:
		starting_level.queue_free()
		main.add_child(lvl02.instantiate())
