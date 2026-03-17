extends StaticBody2D

var item_name = "  Trauma Applicator  "
var item_desc = "Increases dash damage\n
\"They won't even see it coming.\""
var rarity_weight = 20
var one_time = false

func activate_item():
	PlayerAttributes.dash_damage += 20
	queue_free()
