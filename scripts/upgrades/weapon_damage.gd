extends StaticBody2D


var item_name = "  Weapon Damage  "
var item_desc = "Increases weapon damage"
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.weapon_damage += 10
	queue_free()
