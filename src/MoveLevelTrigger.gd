extends Node2D

signal move_level(direction)

onready var move_up = $MoveUp
onready var move_down = $MoveDown
onready var move_left = $MoveLeft
onready var move_right = $MoveRight

const SLEEP_TIME: float = 1.0

var is_sleeping: bool = true
var move_areas: Array = []

func _ready():
	is_sleeping = false
	move_areas = [move_up, move_down, move_left, move_right]

# main function that emits signal to parent
# with the new room direction to move to
func make_move(direction: Vector2):
	call_deferred('disable_triggers')
	emit_signal('move_level', direction)
	yield(get_tree().create_timer(SLEEP_TIME), 'timeout')
	enable_triggers()
		
func disable_triggers():
	is_sleeping = true
	for area in move_areas:
		area.set_deferred('monitoring', false)
		
func enable_triggers():
	is_sleeping = false
	for area in move_areas:
		area.set_deferred('monitoring', true)

func is_player(body: PhysicsBody2D):
	return body and body.name == 'Player'

func _on_MoveUp_body_entered(body: PhysicsBody2D):
	if is_sleeping: return
	if is_player(body):
		make_move(Vector2.UP)

func _on_MoveDown_body_entered(body: PhysicsBody2D):
	if is_sleeping: return
	if is_player(body):
		make_move(Vector2.DOWN)

func _on_MoveLeft_body_entered(body: PhysicsBody2D):
	if is_sleeping: return
	if is_player(body):
		make_move(Vector2.LEFT)

func _on_MoveRight_body_entered(body: PhysicsBody2D):
	if is_sleeping: return
	if is_player(body):
		make_move(Vector2.RIGHT)
