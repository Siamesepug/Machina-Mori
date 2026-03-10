extends StaticBody2D


var item_name = "  Superheated Steel  "
var item_desc = "Chance to ignite enemies on hit\n
\"It burned our home. Nothing was left but ash.\""
var rarity_weight = 10
var one_time = false

func activate_item():
	Elements.has_fire = true
	PlayerAttributes.fire_level += 1
	Elements.gain_element()
	queue_free()
