extends CharacterBody2D
class_name UnkillableEnemy

@onready var path_follow = get_parent()
@onready var path_2d = path_follow.get_parent()
@export var speed = 0.10
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

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
