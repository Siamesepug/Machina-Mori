extends StaticBody2D


var item_name = "  Dash CD  "
var item_desc = "Decreases dash cooldown"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.dash_cd *= 0.8
	queue_free()
