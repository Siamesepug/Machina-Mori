extends StaticBody2D


var item_name = "  Fire Coating  "
var item_desc = "Chance to ignite enemies on hit"

func activate_item():
	Elements.has_fire = true
	PlayerAttributes.fire_level += 1
	queue_free()
