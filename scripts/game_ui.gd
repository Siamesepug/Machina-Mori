extends CanvasLayer

@onready var xp_bar = $HBoxContainer/ProgressBar

func _ready():
	SignalManager.xp_gained.connect(_update_bar)

# manages levelling up the player, and carries over extra xp
func _update_bar(amount):
	var added_xp = xp_bar.value + amount
	
	if added_xp >= xp_bar.max_value:
		var leftover_xp = added_xp - xp_bar.max_value
		
		PlayerAttributes.xp_level += 1
		SignalManager.level_up.emit()
		xp_bar.value = 0
		
		_update_bar(leftover_xp)
	else:
		xp_bar.value += amount
	
	print("Current Level: " + str(PlayerAttributes.xp_level))
