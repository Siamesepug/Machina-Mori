extends StaticBody2D


var item_name = "  Weapon Size  "
var item_desc = "Increases weapon size"

func activate_item():
	PlayerAttributes.weapon_size += 0.15
	queue_free()
