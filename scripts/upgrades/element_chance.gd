extends StaticBody2D


var item_name = "  Elemental Proficiency  "
var item_desc = "Greater chance to apply elements."
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.element_chance -= (PlayerAttributes.element_chance * 0.15)
	print("ELEMENTAL APPLICATION CHANCE: " + str(PlayerAttributes.element_chance))
	queue_free()
