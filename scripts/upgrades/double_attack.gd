extends StaticBody2D

var item_name = "  Dual Process  "
var item_desc = "Attack an additional time,\nbut deal less damage per swing"
var rarity_weight = 10
var one_time = true

func activate_item():
	PlayerAttributes.has_double_attack = true
	PlayerAttributes.weapon_damage *= 0.7
	queue_free()
