extends StaticBody2D

var item_name = "  [color=red]Overclock  "
var item_desc = "[color=red]Higher enemy spawn\nrate, enemy health, [/color]and[color=lime] XP gain\n
[/color] \"No matter how many charged at it, nothing changed.\""
var rarity_weight = 10
var one_time = false

func activate_item():
	EnemyStats.flyer_max_health *= 1.5
	EnemyStats.grunt_max_health *= 1.5
	EnemyStats.spawn_mult += 0.5
	PlayerAttributes.xp_gain *= 1.75
	queue_free()
