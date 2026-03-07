extends Node

var regen_cd = PlayerAttributes.regen_cd
var regen_rate = PlayerAttributes.regen_rate
var heal_timer = 0.0


func _ready():
	SignalManager.damage_player.connect(_took_damage)

func _process(delta):
	if regen_cd > 0:
		regen_cd -= delta
		return # Still on cooldown
	
	if PlayerAttributes.current_health < PlayerAttributes.max_health:
		heal_timer += delta
		if heal_timer >= regen_rate:
			_heal_player()
			heal_timer = 0.0
		

func _heal_player():
	regen_rate = PlayerAttributes.regen_rate
	
	PlayerAttributes.current_health += 1.0
	SignalManager.hp_changed.emit()

func _took_damage():
	regen_cd = PlayerAttributes.regen_cd
	heal_timer = 0.0
