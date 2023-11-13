extends CharacterBody2D
class_name Enemy

@onready var path_follow = get_parent()
@onready var path_2d = $"../.."
@export var speed = 0.15
@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	# find the current location as % of path completed
	var current_progress = path_follow.get_progress_ratio()
	
	# check if enemy made it to one side, then flip sprite 
	if (current_progress < 0.5):
		animated_sprite_2d.flip_h = false
		path_follow.set_progress_ratio(current_progress + speed * delta)
	else:
		animated_sprite_2d.flip_h = true
		path_follow.set_progress_ratio(current_progress + speed * delta)

	move_and_slide()

func die():
	Global.score += 25
	queue_free()