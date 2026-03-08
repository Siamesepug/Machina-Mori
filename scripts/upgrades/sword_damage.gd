extends StaticBody2D


var item_name = "  Sword Damage  "
var item_desc = "Increases sword damage"

func activate_item():
	PlayerAttributes.weapon_damage *= 1.25
	queue_free()
