extends Node

# Holds the player's stats, which the player grabs
# to update it's personal variables.
# You can change these numbers from other scripts such as items/upgrades.
# Avoid directly changing the player's variables.

var current_weapon = "sword"
var weapon_damage = 500.0

var current_health = 100.0
var max_health = 100.0
var regen_cd = 3.0 # seconds before regen starts
var regen_rate = 2.0 # seconds between heals once active

var xp_level = 0
var xp_progress = 0.0
var xp_gain = 60.0

var speed = 400.0
var jump_velocity = -900.0
var dash_speed = 4.0

# Probably don't change this one, used to reset
# movement back to default after dash
var default_speed = 1.0

var max_jumps = 1
