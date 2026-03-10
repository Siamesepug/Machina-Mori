extends StaticBody2D


var item_name = "  Corrosive Coating  "
var item_desc = "Chance to melt enemies on hit\n
\"It melt through the toughest of metals.\""
var rarity_weight = 10
var one_time = false

func activate_item():
	Elements.has_acid = true
	PlayerAttributes.acid_level += 1
	Elements.gain_element()
	queue_free()
