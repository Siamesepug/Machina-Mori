extends CanvasLayer

@onready var xp_bar = $MarginContainer/HBoxContainer/HBoxContainer2/ProgressBar
@onready var hp_bar = $MarginContainer/HBoxContainer/HBoxContainer/HealthBar

func _ready():
	SignalManager.xp_gained.connect(_update_xp_bar)
	SignalManager.hp_changed.connect(_update_hp_bar)

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
