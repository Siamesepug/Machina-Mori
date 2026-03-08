extends CanvasLayer

# Displays 3 random items for the player
# to choose when levelling up

@export var item_list: Array[PackedScene] = []

@onready var slot1 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer
@onready var slot2 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/PanelContainer2
@onready var slot3 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/PanelContainer2
@onready var slot1_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Button
@onready var slot2_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer/Button
@onready var slot3_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/VBoxContainer/Button

@onready var slot1_desc = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/Item1Label
@onready var slot2_desc = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer/Item2Label
@onready var slot3_desc = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/VBoxContainer/Item3Label

var item1 = null
var item2 = null
var item3 = null

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
	
	var item_pool = item_list.duplicate()
	item_pool.shuffle()
	
	# SLOT 1 ==========================================
	var selected_item = item_pool[0]
	item1 = selected_item.instantiate()
	slot1.add_child(item1)
	
	slot1_button.text = item1.item_name
	slot1_desc.text = item1.item_desc
	
	# SLOT 2 ==========================================
	selected_item = item_pool[1]
	item2 = selected_item.instantiate()
	slot2.add_child(item2)
	
	slot2_button.text = item2.item_name
	slot2_desc.text = item2.item_desc
	
	# SLOT 3 ==========================================
	selected_item = item_pool[2]
	item3 = selected_item.instantiate()
	slot3.add_child(item3)
	
	slot3_button.text = item3.item_name
	slot3_desc.text = item3.item_desc


func _on_button_pressed(item: String):
	
	if item == "item1":
		item1.activate_item()
		hide()
	
	elif item == "item2":
		item2.activate_item()
		hide()
	
	elif item == "item3":
		item3.activate_item()
		hide()
	
	item1.queue_free()
	item2.queue_free()
	item3.queue_free()
	
	get_tree().paused = false
