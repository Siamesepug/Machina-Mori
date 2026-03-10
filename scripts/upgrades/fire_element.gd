extends StaticBody2D


var item_name = "  Fire Coating  "
var item_desc = "Chance to ignite enemies on hit"
var rarity_weight = 10
var one_time = false

func activate_item():
	Elements.has_fire = true
	PlayerAttributes.fire_level += 1
	queue_free()
