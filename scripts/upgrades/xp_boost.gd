extends StaticBody2D


var item_name = "  [color=light_blue]++Processing  "
var item_desc = "Increases XP Gain\n
\"It was smart. Smarter than us. That was the problem.\""
var rarity_weight = 15
var one_time = false

func activate_item():
	PlayerAttributes.xp_gain += 2.0
	queue_free()
