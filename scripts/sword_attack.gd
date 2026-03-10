extends Area2D

@onready var player = $"../.."

@onready var damage = player.weapon_damage
@onready var size = player.weapon_size

@onready var collision_shape = $CollisionShape2D
@onready var slash_sprite = $"../SwordSprite"
@onready var facing_left : bool = false

func _ready():
	monitoring = false
	visible = false
	slash_sprite.visible = false
	slash_sprite.scale = Vector2(size, size)
	slash_sprite.modulate = PlayerAttributes.default_slash_color

func swing_sword():
	size = player.weapon_size
	damage = player.weapon_damage
	slash_sprite.scale = Vector2(size, size)
	collision_shape.scale = Vector2(size, size)
	
	# swing up and down, swapping each time
	slash_sprite.flip_v = !slash_sprite.flip_v
	
	if facing_left:
		slash_sprite.flip_h = false
	else:
		slash_sprite.flip_h = true
		
	slash_sprite.play()
	
	monitoring = true
	visible = true
	slash_sprite.visible = true
	
	await get_tree().create_timer(0.2).timeout
	
	monitoring = false
	visible = false
	slash_sprite.visible = false


func _on_sword_attack_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(damage)
	Elements.get_element(body)
