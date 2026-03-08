extends StaticBody2D


var item_name = "  Dash Damage  "
var item_desc = "Increases dash damage"

func activate_item():
	PlayerAttributes.dash_damage *= 1.25
	queue_free()
