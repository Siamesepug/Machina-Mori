extends StaticBody2D


var item_name = "Enhanced Processing"
var item_desc = "Increases XP Gain"

func activate_item():
	PlayerAttributes.xp_gain += 10.0
	print("GRABBED MOVE SPEED")
	queue_free()
