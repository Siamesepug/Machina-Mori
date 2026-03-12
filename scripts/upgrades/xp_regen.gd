extends StaticBody2D


var item_name = "  Process: HEAL  "
var item_desc = "Collecting XP slightly heals.\n\"It fed off the bodies it collected.\""
var rarity_weight = 15
var one_time = false

func activate_item():
	if PlayerAttributes.xp_healing == 0:
		PlayerAttributes.xp_healing += 1
	else:
		PlayerAttributes.xp_healing += 0.25
		PlayerAttributes.xp_healing *= 1.5
	queue_free()
