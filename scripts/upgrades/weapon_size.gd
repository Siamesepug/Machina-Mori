extends StaticBody2D


var item_name = "  Weapon Size  "
var item_desc = "Increases weapon size"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.weapon_size += 0.15
	queue_free()
