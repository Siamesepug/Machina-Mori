extends StaticBody2D

var item_name = "  Laser Beam  "
var item_desc = "Fire a laser when attacking"
var rarity_weight = 1
var one_time = true

func activate_item():
	PlayerAttributes.has_beam = true
	queue_free()
