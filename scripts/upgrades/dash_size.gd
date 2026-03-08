extends StaticBody2D


var item_name = "  Dash Size  "
var item_desc = "Increases dash attack size"

func activate_item():
	PlayerAttributes.dash_size += 0.15
	queue_free()
