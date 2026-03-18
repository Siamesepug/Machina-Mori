extends StaticBody2D


var item_name = "  Armored Casing  "
var item_desc = "Take less damage."
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.armor += 1
	queue_free()
