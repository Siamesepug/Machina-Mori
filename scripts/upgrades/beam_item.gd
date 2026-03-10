extends StaticBody2D

var item_name = "  [color=yellow]Laser Beam[/color]  "
var item_desc = "Fire a laser when attacking\n
\"And in its final form, we knew true fear.\""
var rarity_weight = 100
var one_time = true

func activate_item():
	PlayerAttributes.has_beam = true
	queue_free()
