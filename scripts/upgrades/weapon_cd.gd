extends StaticBody2D


var item_name = "  Attack Speed  "
var item_desc = "Increases attack speed"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.weapon_cd *= 0.8
	queue_free()
