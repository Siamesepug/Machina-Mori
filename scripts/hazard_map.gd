extends TileMapLayer


func _process(delta):
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.tilemap = self
