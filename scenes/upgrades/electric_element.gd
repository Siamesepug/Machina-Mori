extends StaticBody2D


var item_name = "  Supercharged Voltage  "
var item_desc = "Chance to stun and damage enemies on hit\n
\"And his music was...\""
var rarity_weight = 10
var one_time = false

func activate_item():
	Elements.electric_fire = true
	PlayerAttributes.electric_level += 1
	Elements.gain_element()
	queue_free()
