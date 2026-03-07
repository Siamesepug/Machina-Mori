extends Timer

@onready var main = $".."
@onready var lvl01 = $"../Level01"
@onready var lvl02 = load("res://scenes/levels/level02.tscn")

var level_duration = 300 # seconds before levels change

func _ready():
	wait_time = (level_duration)
	
func _process(delta):
	SignalManager.time_left.emit(time_left)

func _on_timeout() -> void:
	if lvl01 != null && lvl01.visible:
		lvl01.queue_free()
		main.add_child(lvl02.instantiate())
