extends "res://src/Levels/BaseLevel.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = name
	disable_move_to_another_level()
	
func disable_move_to_another_level():
	$MoveUp.monitoring = false
	$MoveDown.monitoring = false
	$MoveLeft.monitoring = false
	$MoveRight.monitoring = false
	
func enable_move_to_another_level():
	$MoveUp.monitoring = true
	$MoveDown.monitoring = true
	$MoveLeft.monitoring = true
	$MoveRight.monitoring = true
	
func is_player(body):
	return body.name == 'Player'
	
func _on_MoveUp_body_entered(body):
	if is_player(body):
		var level_coords_to_move_to = coords + Vector2.UP
		emit_signal("move_to_next_level", level_coords_to_move_to)

func _on_MoveDown_body_entered(body):
	if is_player(body):
		var level_coords_to_move_to = coords + Vector2.DOWN
		emit_signal("move_to_next_level", level_coords_to_move_to)

func _on_MoveLeft_body_entered(body):
	if is_player(body):
		var level_coords_to_move_to = coords + Vector2.LEFT
		emit_signal("move_to_next_level", level_coords_to_move_to)

func _on_MoveRight_body_entered(body):
	if is_player(body):
		var level_coords_to_move_to = coords + Vector2.RIGHT
		emit_signal("move_to_next_level", level_coords_to_move_to)
