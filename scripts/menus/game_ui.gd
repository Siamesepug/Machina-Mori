extends CanvasLayer

@onready var xp_bar = $MarginContainer/HBoxContainer/HBoxContainer2/ProgressBar
@onready var xp_label = $MarginContainer/HBoxContainer/HBoxContainer2/Label
@onready var hp_bar = $MarginContainer/HBoxContainer/HealthBar
@onready var hp_label = $MarginContainer/HBoxContainer/HealthBar/HealthLabel

@onready var time_left = $MarginContainer/HBoxContainer/TimeLeft
@onready var low_health_display = $LowHealth

@onready var dash_bar = $MarginContainer2/AbilityBar/VBoxContainer/DashProgress
@onready var dash_cooldown = $MarginContainer2/AbilityBar/VBoxContainer/DashProgress/DashCDLabel
@onready var slash_bar = $MarginContainer2/AbilityBar/VBoxContainer2/SlashProgress
@onready var slash_cooldown = $MarginContainer2/AbilityBar/VBoxContainer2/SlashProgress/SlashCDLabel
@onready var beam_bar = $MarginContainer2/AbilityBar/VBoxContainer3/BeamProgress
@onready var beam_cooldown = $MarginContainer2/AbilityBar/VBoxContainer3/BeamProgress/BeamCDLabel
@onready var beam_icon = $MarginContainer2/AbilityBar/VBoxContainer3

func _ready():
	SignalManager.xp_gained.connect(_update_xp_bar)
	SignalManager.hp_changed.connect(_update_hp_bar)
	SignalManager.time_left.connect(_update_time_left)
	SignalManager.dash_cd_start.connect(_update_dash_progress)
	SignalManager.slash_cd_start.connect(_update_slash_progress)
	SignalManager.beam_cd_start.connect(_update_beam_progress)
	
	xp_label.text = ("Level: " + str(PlayerAttributes.xp_level))
	low_health_display.visible = false
	beam_icon.visible = false

# manages levelling up the player, and carries over extra xp
func _update_xp_bar(amount):
	var added_xp = xp_bar.value + amount
	
	if added_xp >= xp_bar.max_value:
		var leftover_xp = added_xp - xp_bar.max_value
		
		level_up_stats()
		PlayerAttributes.xp_level += 1
		xp_bar.max_value += PlayerAttributes.xp_per_level_increase
		SignalManager.level_up.emit()
		xp_label.text = ("Level: " + str(PlayerAttributes.xp_level))
		
		xp_bar.value = 0
		
		_update_xp_bar(leftover_xp)
	else:
		xp_bar.value += amount
	
	print("Current Level: " + str(PlayerAttributes.xp_level))

func level_up_stats():
	if !PlayerAttributes.glass_cannon:
		PlayerAttributes.max_health += 5
	PlayerAttributes.weapon_damage += 2
	PlayerAttributes.dash_damage += 2
	PlayerAttributes.jump_velocity -= 10
	PlayerAttributes.speed *= 1.02

func _update_hp_bar():
	hp_bar.max_value = PlayerAttributes.max_health
	hp_bar.value = PlayerAttributes.current_health
	
	hp_label.text = (str(int(PlayerAttributes.current_health)) + "/" + str(int(PlayerAttributes.max_health)))
	
	if PlayerAttributes.current_health < (PlayerAttributes.max_health * 0.1):
		_display_low_health(true)
	else:
		_display_low_health(false)

func _update_time_left(time):
	var minutes = int(time / 60)
	var secs = int(time) % 60
	
	time_left.text = ("TIME LEFT\n" + str(minutes) + ":" + str("%02d" % secs))

func _display_low_health(active):
	if active:
		low_health_display.visible = true
		var tween = create_tween()
		
		tween.tween_property(low_health_display, "modulate:a", 0.2, 2.0)
	else:
		low_health_display.visible = false
		var tween = create_tween()
		
		tween.tween_property(low_health_display, "modulate:a", 0.0, 2.0)

# ABILITY BAR ==================================================================
func _update_dash_progress():
	dash_bar.value = 0.0
	var dash_cd = PlayerAttributes.dash_cd
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(dash_bar, "value", dash_bar.max_value, dash_cd)
	
	tween.tween_method(func(time_passed):
		var remaining_time = dash_cd - time_passed
		dash_cooldown.text = str(snapped(remaining_time, 0.1)) + " S", 0.0, dash_cd, dash_cd)
	
	tween.chain().tween_callback(func(): dash_cooldown.text = "Ready")

func _update_slash_progress():
	slash_bar.value = 0.0
	var slash_cd = PlayerAttributes.weapon_cd
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(slash_bar, "value", slash_bar.max_value, slash_cd)
	
	tween.tween_method(func(time_passed):
		var remaining_time = slash_cd - time_passed
		slash_cooldown.text = str(snapped(remaining_time, 0.1)) + " S", 0.0, slash_cd, slash_cd)
	
	tween.chain().tween_callback(func(): slash_cooldown.text = "Ready")

func _update_beam_progress():
	if beam_icon.visible == false:
		beam_icon.visible = true
	
	if beam_bar.value == beam_bar.max_value: # only activate when full
		beam_bar.value = 0.0
		var beam_cd = PlayerAttributes.beam_cd
		var tween = create_tween().set_parallel(true)
		
		tween.tween_property(beam_bar, "value", beam_bar.max_value, beam_cd)
		
		tween.tween_method(func(time_passed):
			var remaining_time = beam_cd - time_passed
			beam_cooldown.text = str(snapped(remaining_time, 0.1)) + " S", 0.0, beam_cd, beam_cd)
		
		tween.chain().tween_callback(func(): beam_cooldown.text = "Ready")
