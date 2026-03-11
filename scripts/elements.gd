extends Node

var has_element : bool = false
var element_count = 5 # amount of elements the player could have

var has_fire : bool = false
var has_frost : bool = false
var has_acid : bool = false
var has_electric : bool = false
var has_bleed : bool = false

var fire_decay : float = 1.0 # how fast elements "burn"
var frost_decay : float = 1.0
var acid_decay : float = 1.0
var electric_decay : float = 1.0
var bleed_decay : float = 1.0

func get_element(body: CharacterBody2D):
	if has_element:
		while has_element:
			var element_select = randi_range(1, element_count)
			
			# Basically spins a wheel until it hits one of the elements the player has
			match element_select:
				1:
					# FIRE
					if has_fire:
						trigger_fire(body)
						break
					else:
						continue
				2:
					# FROST
					if has_frost:
						trigger_frost(body)
						break
					else:
						continue
				3:
					# ACID
					if has_acid:
						trigger_acid(body)
						break
					else:
						continue
				4:
					# ELECTRIC
					if has_electric:
						trigger_electric(body)
						break
					else:
						continue
				5:
					# BLEED
					if has_bleed:
						trigger_bleed(body)
						break
					else:
						continue

func gain_element():
	has_element = true

func trigger_fire(body: CharacterBody2D):
	# Check the current level of fire item, for multiplier of damage, etc.
	# then tell the attacking zone to apply the element, or maybe do it here?
	var fire_stacks = PlayerAttributes.fire_level * PlayerAttributes.fire_mult
	var fire_damage = PlayerAttributes.fire_level * PlayerAttributes.fire_damage
	body.on_fire(fire_stacks, fire_damage)

func trigger_frost(body: CharacterBody2D):
	var frost_stacks = PlayerAttributes.frost_level * PlayerAttributes.frost_mult
	var frost_damage = PlayerAttributes.frost_level * PlayerAttributes.frost_damage
	var slow_duration = PlayerAttributes.frost_slow
	body.on_frost(frost_stacks, frost_damage, slow_duration)

func trigger_acid(body: CharacterBody2D):
	var acid_stacks = PlayerAttributes.acid_level * PlayerAttributes.acid_mult
	var acid_damage = PlayerAttributes.acid_level * PlayerAttributes.acid_damage
	body.on_acid(acid_stacks, acid_damage)

func trigger_electric(body: CharacterBody2D):
	var electric_stacks = PlayerAttributes.electric_level * PlayerAttributes.electric_mult
	var electric_damage = PlayerAttributes.electric_level * PlayerAttributes.electric_damage
	var stun_duration = PlayerAttributes.electric_stun
	body.on_electric(electric_stacks, electric_damage, stun_duration)

func trigger_bleed(body: CharacterBody2D):
	var bleed_stacks = PlayerAttributes.bleed_level * PlayerAttributes.bleed_mult
	var bleed_damage = PlayerAttributes.bleed_level * PlayerAttributes.bleed_damage
	body.on_bleed(bleed_stacks, bleed_damage)
