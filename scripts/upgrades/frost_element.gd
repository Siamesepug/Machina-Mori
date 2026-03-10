extends StaticBody2D


var item_name = "  Cryo Cooling  "
var item_desc = "Chance to slow and damage enemies on hit\n
\"The frost spread across the system. The air itself began to freeze.\""
var rarity_weight = 10
var one_time = false

func activate_item():
	Elements.has_frost = true
	PlayerAttributes.frost_level += 1
	Elements.gain_element()
	queue_free()
