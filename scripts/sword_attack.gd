extends Area2D

@onready var player = $"../.."

@onready var damage = player.weapon_damage
@onready var size = player.weapon_size

@onready var collision_shape = $CollisionShape2D
@onready var slash_sprite = $"../SwordSprite"
@onready var facing_left : bool = false

var slash_style = true # false for down swing, true for side swing, swap between these

func _ready():
	monitoring = false
	visible = false
	slash_sprite.visible = false
	slash_sprite.scale = Vector2(size, size)
	slash_sprite.modulate = PlayerAttributes.default_slash_color
	slash_sprite.animation = "idle"

func swing_sword():
	size = player.weapon_size
	damage = player.weapon_damage
	slash_sprite.scale = Vector2(size, size)
	collision_shape.scale = Vector2(size, size)
	
	# swing up and down, swapping each time
	slash_style = !slash_style
	if slash_style:
		slash_sprite.animation = "swing_side"
	else:
		slash_sprite.animation = "swing_down"
	
	if facing_left:
		slash_sprite.flip_h = true
	else:
		slash_sprite.flip_h = false
		
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
