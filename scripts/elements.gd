extends Node

var has_element : bool = false
var element_count = 0 # amount of elements the player currently has

var has_fire : bool = false
var has_frost : bool = false
var has_acid : bool = false
var has_electric : bool = false
var has_bleed : bool = false

func get_element():
	if has_element:
		while has_element:
			var element_select = randi_range(1, element_count)
			
			# Basically spins a wheel until it hits one of the elements the player has
			match element_select:
				1:
					# FIRE
					if has_fire:
						trigger_fire()
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

func trigger_fire():
	# Check the current level of fire item, for multiplier of damage, etc.
	# then tell the attacking zone to apply the element, or maybe do it here?
	pass
