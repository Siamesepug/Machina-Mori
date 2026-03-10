extends StaticBody2D

var item_name = "  Pressure Boots  "
var item_desc = "Jump higher\n
\"Get up to where you need to get up to.\""
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.jump_velocity *= 1.1
	queue_free()
