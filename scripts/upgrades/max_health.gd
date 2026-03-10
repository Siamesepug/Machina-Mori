extends StaticBody2D


var item_name = "  Durable Casing  "
var item_desc = "Increases max health\n
\"Nothing we used even dented it.\""
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.max_health += 50
	queue_free()
