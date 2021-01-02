extends Node2D

onready var tween = $Tween
onready var camera = $Camera2D
onready var level_coordinator = $LevelCoordinator

const LEVEL_TRANSITION_TIME: float = 0.5

export var start_at_home_level: bool = true

var current_level
var current_level_coords = Vector2.ZERO

var x_over_y = true

# Called when the node enters the scene tree for the first time.
func _ready():
	level_coordinator.init()
	level_coordinator.scan()
	level_coordinator.create_scanned_level()
	
	yield(get_tree().create_timer(3.0), 'timeout')
	test_move_level()

func test_move_level():
	
	var x = current_level_coords.x + 1 if x_over_y else current_level_coords.x
	var y = current_level_coords.y + 1 if not x_over_y else current_level_coords.y
	
	current_level_coords = Vector2(x, y)

	level_coordinator.current_level_coords = current_level_coords
	print(level_coordinator.current_level_coords)
	level_coordinator.scan()
	level_coordinator.dispose()
	level_coordinator.create_scanned_level()
	
	x_over_y = !x_over_y
	
	yield(get_tree().create_timer(2.0), 'timeout')
	test_move_level()
	
