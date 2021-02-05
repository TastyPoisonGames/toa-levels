extends Control

onready var rect = $ColorRect
onready var options = $OptionButton

var list = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	rect.visible = false
	options.visible = false

	add_options()
	
func add_options():
	var levels = owner.get_node('Levels').get_children()
	for i in range(levels.size()):
		var l = levels[i]
		options.add_item(l.get_name(), i)
		list[i] = l.get_name()

func _unhandled_key_input(event):
	if event.is_action_released("ui_select"):
		options.visible = !options.visible
		rect.visible = options.visible

func _on_OptionButton_item_selected(index):
	var level_name = list[index]
	print('chosen ' + level_name)
	var segments = level_name.split('_')
	var x_coord = float(segments[1])
	var y_coord = float(segments[2])
	var position_x = x_coord * 1280
	var position_y = y_coord * 720
	owner._on_go_to_next_level(Vector2(x_coord, y_coord))
	
