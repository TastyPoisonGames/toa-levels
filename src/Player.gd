extends KinematicBody2D

export (int) var speed = 500

var is_running: bool = false
var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        velocity.x += 2
        is_running = true
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 2
        is_running = true
    if Input.is_action_pressed('ui_down'):
        velocity.y += 2
        is_running = true
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 2
        is_running = true
        
    if Input.is_action_just_released('ui_right'):
        velocity.x += 2
        is_running = false
    if Input.is_action_just_released('ui_left'):
        velocity.x -= 2
        is_running = false
    if Input.is_action_just_released('ui_down'):
        velocity.y += 2
        is_running = false
    if Input.is_action_just_released('ui_up'):
        velocity.y -= 2
        is_running = false
    velocity = velocity.normalized() * speed

func _physics_process(_delta):
    get_input()
    velocity = move_and_slide(velocity)
