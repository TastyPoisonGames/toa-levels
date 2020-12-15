extends Node2D

onready var tween = $Tween
onready var camera = $Camera2D

var current_level
var current_level_coords = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var levels = get_node("Levels")
	for level in levels.get_children():
		var level_name: String = level.get_name()
		if not level_name.begins_with('Level'):
			continue
		var segments = level_name.split('_')
		var x_coord = float(segments[1])
		var y_coord = float(segments[2])
		level.set_level_coordinates(Vector2(x_coord, y_coord))
		level.connect('move_to_next_level', self, '_on_go_to_next_level')
	current_level = get_level()
	tween.connect('tween_completed', self, '_on_level_camera_finished')
	current_level.enable_move_to_another_level()
	
func _on_go_to_next_level(next_level_coords: Vector2):
	var player = current_level.take_out_player()
	var direction_came_from
	
	if current_level_coords.x > next_level_coords.x:
		direction_came_from = 'right'
	elif current_level_coords.x < next_level_coords.x:
		direction_came_from = 'left'
	elif current_level_coords.y > next_level_coords.y:
		direction_came_from = 'down'
	else:
		direction_came_from = 'up'
	
	current_level_coords = next_level_coords
	var next_level = get_level()
	assert(next_level != null, "ERROR! You tried to move to a level that does not exist " + str(current_level_coords))
	next_level.add_player(player, direction_came_from)
	move_camera()

func get_level():
	return get_node('Levels/' + get_level_name())
	
func move_camera():
	var level_position = get_level().position
	tween.interpolate_property(
		camera,
		'offset',
		camera.offset,
		level_position,
		0.4,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	tween.start()
	
func _on_level_camera_finished(object: Object, key: NodePath):
	var next_level = get_level()
	current_level = next_level
	current_level.enable_move_to_another_level()

func get_level_name():
	return 'Level_' + str(current_level_coords.x) + '_' + str(current_level_coords.y)
