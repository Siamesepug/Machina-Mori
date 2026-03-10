extends StaticBody2D

var item_name = "  Overclock  "
var item_desc = "Higher enemy spawn rate,\nenemy health, and XP gain"
var rarity_weight = 10
var one_time = false

func activate_item():
	EnemyStats.flyer_max_health *= 1.5
	EnemyStats.grunt_max_health *= 1.5
	EnemyStats.spawn_mult += 0.5
	PlayerAttributes.xp_gain *= 1.75
	queue_free()
