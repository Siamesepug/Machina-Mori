extends StaticBody2D


var item_name = "Durable Casing"
var item_desc = "Increases max health"

func activate_item():
	PlayerAttributes.max_health += 50
	queue_free()
