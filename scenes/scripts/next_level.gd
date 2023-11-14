extends Area2D
@onready var next_level = $NextLevel
@onready var collision_shape_2d = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(_body):
	get_tree().set_pause(true)
	
	next_level.play()
	await(next_level.finished)
	get_tree().change_scene_to_file("res://scenes/Levels/level_2.tscn")
