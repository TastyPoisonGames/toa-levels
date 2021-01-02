extends Node2D

var coords = Vector2.ZERO
var direction_position_map = {
	'up': 48,
	'down': 672,
	'left': 48,
	'right': 1232,
}

signal move_to_next_level(coords_vector)

func _ready():
	set_level_coordinates()

func set_level_coordinates():
	if name == 'Level': return
	var segments = name.split('_')
	var x_coord = float(segments[1])
	var y_coord = float(segments[2])
	coords = Vector2(x_coord, y_coord)
	
func take_out_player():
	var y_sort = get_node('YSort')
	var player = y_sort.get_node('Player')
	if player:
		y_sort.remove_child(player)
	return player
	
func add_player(player, direction_came_from: String):
	if not player:
		return
	var y_sort = get_node('YSort')
	y_sort.add_child(player)
	player.freeze()
	if direction_came_from == 'left' or direction_came_from == 'right':
		player.position.x = direction_position_map[direction_came_from]
	else:
		player.position.y = direction_position_map[direction_came_from]
	
func disable_move_to_another_level():
	print('disable room')
	
func enable_move_to_another_level():
	print('enable room')
