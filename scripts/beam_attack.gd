extends Area2D

@onready var player = $"../.."

@onready var damage = player.weapon_damage
@onready var size = player.weapon_size
@onready var camera = $"../../Camera2D"

@onready var collision_shape = $CollisionShape2D
@onready var beam_timer = $BeamCD
@onready var beam_light = $"../BeamLight"
@onready var beam_audio = $"../BeamAudio"
@onready var beam_sprite = $Sprite2D

var can_fire = true
var beam_duration = PlayerAttributes.beam_duration

func _ready():
	monitoring = false
	visible = false
	beam_light.visible = false

func _physics_process(delta):
	if visible:
		monitoring = !monitoring
	else:
		monitoring = false

func is_firing():
	if !can_fire:
		return # still on cooldown
	
	can_fire = false
	beam_timer.wait_time = PlayerAttributes.beam_cd
	beam_timer.start()
	beam_audio.play()
	beam_sprite.material.set_shader_parameter("progress", 0.0)
	
	size = player.weapon_size
	damage = player.weapon_damage * 0.1
	beam_duration = PlayerAttributes.beam_duration
	
	collision_shape.scale = Vector2(size, size)
	
	# animation for starting laser
	var tween_start = create_tween()
	
	tween_start.tween_property(beam_sprite.material, "shader_parameter/progress", 1.0, 0.5)
	
	monitoring = true
	visible = true
	beam_light.visible = true
	
	var temp_decay = camera.decay
	camera.decay /= 40
	
	camera.shake_amount(1.0)
	# HOW LONG BEAM LASTS, NEED TO CHANGE
	await get_tree().create_timer(beam_duration).timeout
	
	var tween_end = create_tween()
	tween_end.tween_property(beam_sprite.material, "shader_parameter/progress", 0.0, 0.5)
	
	await tween_end.finished
	
	camera.decay = temp_decay
	monitoring = false
	visible = false
	beam_light.visible = false

func _on_dash_attack_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(damage)


func _on_beam_cd_timeout():
	can_fire = true
