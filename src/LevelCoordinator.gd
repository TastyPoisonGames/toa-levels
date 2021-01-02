extends Node2D

signal levels_created

export(NodePath) onready var levels = get_node(levels) as Node2D
export var initial_level_coords = Vector2(0, 0)

const ROOM_RADIUS = 2

var current_level_coords
var level_name_template = "Level_{x}_{y}"
var level_path_template = "res://src/NewLevels/Level_{x}_{y}.tscn"
var levels_to_create: Array = []
var thread = Thread.new()

# create the main level where the player starts
func init():
	current_level_coords = initial_level_coords
	
func coordinate(coords: Vector2):
	current_level_coords = coords
	dispose()
	scan()
	check_level_creation()
	
## see how many levels need creating in radius
func scan():
	levels_to_create = []
	var levels_coords_to_check = get_levels_in_radius()
	for coord in levels_coords_to_check:
		var level_to_check = get_level_name(coord)
		if not levels.has_node(level_to_check):
			levels_to_create.append(coord)
	
func dispose():
	garbage_collect_levels_outside_radius()
	
func get_levels_in_radius() -> Array:
	 return [
		current_level_coords,
		current_level_coords + Vector2.UP,
		current_level_coords + Vector2.DOWN,
		current_level_coords + Vector2.LEFT,
		current_level_coords + Vector2.RIGHT,
		current_level_coords + Vector2(1, -1),
		current_level_coords + Vector2(-1, 1),
		current_level_coords + Vector2(-1, -1),
		current_level_coords + Vector2(1, 1)
	]
	
func garbage_collect_levels_outside_radius():
	var current_radius = get_levels_in_radius()
	for level in levels.get_children():
		var level_name: String = level.get_name()
		if not level_name.begins_with('Level'):
			continue
		var segments = level_name.split('_')
		var x_coord = float(segments[1])
		var y_coord = float(segments[2])
		if not current_radius.has(Vector2(x_coord, y_coord)):
			levels.remove_child(level)
			level.queue_free()

# trigger thread
func check_level_creation():
	var level_to_create_coords = levels_to_create.pop_front()
	if level_to_create_coords == null:
		emit_signal('levels_created')
		return
	var level = _load_level(level_to_create_coords)
	_create_level(level)
#	thread.start(self, '_load_level', level_to_create_coords)

# thread function
func _load_level(level_coords: Vector2):
	var level = null
	var level_to_load = format_level_name(level_path_template, level_coords)
	var level_exists: bool = ResourceLoader.exists(level_to_load)
	if level_exists:
		level = load(level_to_load).instance()
		level.name = format_level_name(level_name_template, level_coords)
		var position_on_map = Vector2(
			1280 * level_coords.x,
			720 * level_coords.y
		)
		level.position = position_on_map
#	call_deferred('_create_level')
	return level

# thread load done
func _create_level(level):
#	var level = thread.wait_to_finish()
	if level != null:
		levels.add_child(level)
	check_level_creation()
	
func format_level_name(string_to_change: String, level_coords: Vector2):
	return string_to_change.format({
		"x": str(level_coords.x),
		"y": str(level_coords.y)
	})

func get_level_name(level_coords):
	return 'Level_' + str(level_coords.x) + '_' + str(level_coords.y)
