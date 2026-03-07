extends Area2D

@onready var player = $".."

@onready var damage = player.weapon_damage

func _ready():
	#monitoring = false
	#visible = false
	pass

func swing_sword():
	#monitoring = true
	#visible = true
	
	await get_tree().create_timer(1.0).timeout
	
	#monitoring = false
	#visible = false


func _on_sword_attack_body_entered(body: CharacterBody2D) -> void:
	#if body == player:
	#	return # Don't hurt the player
	print(body)
	body.take_damage(damage)
