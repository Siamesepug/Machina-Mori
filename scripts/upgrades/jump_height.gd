extends StaticBody2D

var item_name = "  Jump Boost  "
var item_desc = "Jump higher"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.jump_velocity *= 1.1
	queue_free()
