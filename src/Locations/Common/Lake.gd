extends Node2D

onready var area_2d: Area2D = $Area2D

func _ready():
	area_2d.connect("body_entered", self, '_on_entered_lake')
	
func _on_entered_lake(body: PhysicsBody2D):
	pass

