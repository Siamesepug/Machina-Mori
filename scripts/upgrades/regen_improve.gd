extends StaticBody2D


var item_name = "  Power Supply  "
var item_desc = "Increases regen amount"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.regen_amount += 1
	queue_free()
