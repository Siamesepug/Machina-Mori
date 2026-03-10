extends CanvasLayer

# Displays 3 random items for the player
# to choose when levelling up

@export var item_list: Array[PackedScene] = []

@onready var slot1 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer
@onready var slot2 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PanelContainer2
@onready var slot3 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/PanelContainer2

@onready var slot1_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Button
@onready var slot1_name = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Button/Item1Label2

@onready var slot2_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer/Button
@onready var slot2_name = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer/Button/Item1Label2

@onready var slot3_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/VBoxContainer/Button
@onready var slot3_name = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/VBoxContainer/Button/Item1Label2

@onready var slot1_desc = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Item1Label2
@onready var slot2_desc = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer/Item1Label2
@onready var slot3_desc = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/VBoxContainer/Item1Label2

var item1 = null
var item2 = null
var item3 = null

var taken_one_time_items : Array[String] = []

func _ready():
	hide()
	SignalManager.level_up.connect(show_menu)

func show_menu():
	show()
	get_tree().paused = true
	generate_random_items()

func generate_random_items():
	# Takes the list of items, makes a copy, shuffles the copy,
	# and chooses the first few items in the new list
	
	var item_pool = []
	
	for scene in item_list:
		var item = scene.instantiate()
		
		if item.one_time and item.item_name in taken_one_time_items:
			item.queue_free()
			continue
		
		item_pool.append(scene)
		item.queue_free()
	
	# SLOT 1 ==========================================
	var selected_item = get_weighted_item(item_pool)
	item_pool.erase(selected_item)
	item1 = selected_item.instantiate()
	slot1.add_child(item1)
	
	slot1_name.text = item1.item_name
	slot1_desc.text = item1.item_desc
	
	# SLOT 2 ==========================================
	selected_item = get_weighted_item(item_pool)
	item_pool.erase(selected_item)
	item2 = selected_item.instantiate()
	slot2.add_child(item2)
	
	slot2_name.text = item2.item_name
	slot2_desc.text = item2.item_desc
	
	# SLOT 3 ==========================================
	selected_item = get_weighted_item(item_pool)
	item_pool.erase(selected_item)
	item3 = selected_item.instantiate()
	slot3.add_child(item3)
	
	slot3_name.text = item3.item_name
	slot3_desc.text = item3.item_desc

func get_weighted_item(pool):
	var total_weight = 0
	
	for scene in pool:
		var item = scene.instantiate()
		total_weight += item.rarity_weight
		item.queue_free()
	
	var roll = randi() % total_weight
	var sum = 0
	
	for scene in pool:
		var item = scene.instantiate()
		sum += item.rarity_weight
		
		if roll < sum:
			item.queue_free()
			return scene
		
		item.queue_free()
	return pool[0]

func _on_button_pressed(item: String):
	
	if item == "item1":
		item1.activate_item()
		
		if item1.one_time:
			taken_one_time_items.append(item1.item_name)
		
		hide()
	
	elif item == "item2":
		item2.activate_item()
		
		if item2.one_time:
			taken_one_time_items.append(item2.item_name)
		
		hide()
	
	elif item == "item3":
		item3.activate_item()
		
		if item3.one_time:
			taken_one_time_items.append(item3.item_name)
		
		hide()
	
	item1.queue_free()
	item2.queue_free()
	item3.queue_free()
	
	get_tree().paused = false
