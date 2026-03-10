extends Node

var has_element : bool = true
var element_count = 1 # amount of elements the player currently has

var has_fire : bool = true
var has_frost : bool = false
var has_acid : bool = false
var has_electric : bool = false
var has_bleed : bool = false

var fire_decay : float = 1.0 # how fast elements "burn"

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
						pass
					else:
						continue
				3:
					# ACID
					if has_acid:
						pass
					else:
						continue
				4:
					# ELECTRIC
					if has_electric:
						pass
					else:
						continue
				5:
					# BLEED
					if has_bleed:
						pass
					else:
						continue

func gain_element():
	has_element = true
	element_count += 1

func trigger_fire(body: CharacterBody2D):
	# Check the current level of fire item, for multiplier of damage, etc.
	# then tell the attacking zone to apply the element, or maybe do it here?
	var fire_stacks = PlayerAttributes.fire_level * PlayerAttributes.fire_mult
	var fire_damage = PlayerAttributes.fire_level * PlayerAttributes.fire_mult
	body.on_fire(fire_stacks, fire_damage)
