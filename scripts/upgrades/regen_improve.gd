extends StaticBody2D


var item_name = "  Power Supply  "
var item_desc = "Increases regen rate"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.regen_rate *= 0.5 # seconds between regens
	queue_free()
