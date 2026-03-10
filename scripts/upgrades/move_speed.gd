extends StaticBody2D


var item_name = "  Move Speed  "
var item_desc = "Increases move speed"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.speed += 100
	print("GRABBED MOVE SPEED")
	queue_free()
