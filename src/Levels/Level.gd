extends "res://src/Levels/BaseLevel.gd"

onready var move_level_trigger = $MoveLevelTrigger

# Called when the node enters the scene tree for the first time.
func _ready():
	move_level_trigger.connect("move_level", self, 'on_move_level')
	disable_move_to_another_level()
	
func disable_move_to_another_level():
	move_level_trigger.disable_triggers(self.name)
	
func enable_move_to_another_level():
	move_level_trigger.enable_triggers(self.name)
	
func on_move_level(direction):
	var level_coords_to_move_to = coords + direction
	emit_signal("move_to_next_level", level_coords_to_move_to)
	print('emitted move to next level: ' + str(level_coords_to_move_to))
