extends StaticBody2D


var item_name = "  ++Processing  "
var item_desc = "Increases XP Gain"
var rarity_weight = 15
var one_time = false

func activate_item():
	PlayerAttributes.xp_gain += 10.0
	queue_free()
