extends CanvasLayer

@onready var xp_bar = $MarginContainer/HBoxContainer/HBoxContainer2/ProgressBar
@onready var hp_bar = $MarginContainer/HBoxContainer/HBoxContainer/HBoxContainer/HealthBar
@onready var hp_label = $MarginContainer/HBoxContainer/HBoxContainer/HBoxContainer/HealthLabel

@onready var time_left = $MarginContainer/HBoxContainer/TimeLeft

func _ready():
	SignalManager.xp_gained.connect(_update_xp_bar)
	SignalManager.hp_changed.connect(_update_hp_bar)
	SignalManager.time_left.connect(_update_time_left)

# manages levelling up the player, and carries over extra xp
func _update_xp_bar(amount):
	var added_xp = xp_bar.value + amount
	
	if added_xp >= xp_bar.max_value:
		var leftover_xp = added_xp - xp_bar.max_value
		
		PlayerAttributes.xp_level += 1
		SignalManager.level_up.emit()
		xp_bar.value = 0
		
		_update_xp_bar(leftover_xp)
	else:
		xp_bar.value += amount
	
	print("Current Level: " + str(PlayerAttributes.xp_level))

func _update_hp_bar():
	hp_bar.value = PlayerAttributes.current_health
	hp_label.text = (str(int(PlayerAttributes.current_health)) + "/" + str(int(PlayerAttributes.max_health)))

func _update_time_left(time):
	var minutes = int(time / 60)
	var secs = int(time) % 60
	
	time_left.text = ("TIME LEFT\n" + str(minutes) + ":" + str("%02d" % secs))
