extends StaticBody2D


var item_name = "  Accelerated Capacity  "
var item_desc = "Increases move speed\n
\"Get a pep in your step.\""
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.speed += 100
	print("GRABBED MOVE SPEED")
	queue_free()
