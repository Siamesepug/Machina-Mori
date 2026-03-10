extends StaticBody2D

var item_name = "  Dash Size  "
var item_desc = "Increases dash attack size"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.dash_size += 0.15
	queue_free()
