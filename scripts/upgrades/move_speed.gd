extends StaticBody2D


var item_name = "  Move Speed  "
var item_desc = "Increases move speed"

func activate_item():
	PlayerAttributes.speed += 100
	print("GRABBED MOVE SPEED")
	queue_free()
