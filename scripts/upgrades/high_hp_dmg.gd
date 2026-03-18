extends StaticBody2D


var item_name = "  Power Surge  "
var item_desc = "Deal increased damage against full health targets."
var rarity_weight = 10
var one_time = false

func activate_item():
	PlayerAttributes.high_health_bonus_dmg += 10
	queue_free()
