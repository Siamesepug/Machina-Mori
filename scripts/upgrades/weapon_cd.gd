extends StaticBody2D


var item_name = "  Attack Speed  "
var item_desc = "Increases attack speed"

func activate_item():
	PlayerAttributes.weapon_cd *= 0.8
	queue_free()
