extends StaticBody2D


var item_name = "  Dash CD  "
var item_desc = "Decreases dash cooldown"

func activate_item():
	PlayerAttributes.dash_cd *= 0.8
	queue_free()
