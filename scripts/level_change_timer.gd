extends Timer

@onready var main = $".."
@onready var starting_level = $"../Level01"
@onready var lvl01 = load("res://scenes/levels/level01.tscn")
@onready var lvl02 = load("res://scenes/levels/level02.tscn")

var level_duration = PlayerAttributes.level_duration # seconds before levels change

func _ready():
	#starting_level.queue_free()
	#main.add_child(lvl01.instantiate())
	wait_time = (level_duration)
	
	
func _process(delta):
	SignalManager.time_left.emit(time_left)

func _on_timeout() -> void:
	if lvl01 != null && lvl01.visible:
		lvl01.queue_free()
		main.add_child(lvl02.instantiate())
