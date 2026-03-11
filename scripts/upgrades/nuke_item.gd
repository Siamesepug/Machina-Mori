extends StaticBody2D

var item_name = "  [color=yellow]Nuclear Blast[/color]  "
var item_desc = "When at [color=red]0 health[/color], explode, and [color=lime]gain max life.\n[color=red]One Time Use[/color]\n
[/color]\"The horizon lit up with fire. Our fates were long sealed.\""
var rarity_weight = 1
var one_time = true

func activate_item():
	PlayerAttributes.has_nuke = true
	queue_free()
