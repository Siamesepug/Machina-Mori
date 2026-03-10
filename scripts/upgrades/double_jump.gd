extends StaticBody2D

var item_name = "  Double Jump  "
var item_desc = "Jump one additional time"
var rarity_weight = 10
var one_time = false

func activate_item():
	PlayerAttributes.max_jumps += 1
	print("GRABBED DOUBLE JUMP")
	queue_free()
