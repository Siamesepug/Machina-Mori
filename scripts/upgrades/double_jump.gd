extends StaticBody2D

var item_name = "  [color=purple]Extra Thrust[/color]  "
var item_desc = "Jump one additional time\n
\"It soared over entire circuits in a single leap.\""
var rarity_weight = 10
var one_time = false

func activate_item():
	PlayerAttributes.max_jumps += 1
	print("GRABBED DOUBLE JUMP")
	queue_free()
