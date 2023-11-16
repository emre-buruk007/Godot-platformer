extends CharacterBody2D
class_name MainCharacter

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_death = $player_death
@onready var collision_shape_2d = $CollisionShape2D
@onready var main_character = $"."

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#Animation
	if (velocity.x > 1 || velocity.x < -1):
		animated_sprite_2d.play("walking")
	else:
		animated_sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# enemy collision kill and death logic
	# this loop breaks
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		var deadly_collision = is_collision_deadly(collider, collision)
		var is_stomping = is_player_stomping(collider, collision)
		
		if is_stomping:
			velocity.y = JUMP_VELOCITY / 2
			collider.die()
			
		elif deadly_collision:
			player_die()
			break
	
	# logic to turn the sprite during movement
	var isLeft = velocity.x < 0
	animated_sprite_2d.flip_h = isLeft


func player_die() -> void:
	animated_sprite_2d.visible = false
	collision_shape_2d.disabled = true
	player_death.play()
	await(player_death.finished)
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
	

func is_collision_deadly(collider, collision) ->bool:
	var deadly_collision = null
	var enemy_classes_arr = Global.types_of_enemies
	
	for enemy_type in enemy_classes_arr:
		if collider.name == enemy_type:
			deadly_collision = (collision.get_normal().dot(Vector2.RIGHT)> 0.1 or 
			collision.get_normal().dot(Vector2.LEFT)> 0.1 or
			collision.get_normal().dot(Vector2.DOWN)> 0.1)
	
	if deadly_collision:
		return true
		
	else:
		return false

func is_player_stomping(collider, collision) -> bool:
	if (collider.name in Global.types_of_enemies and is_on_floor() and 
	collision.get_normal().dot(Vector2.UP) > 0.5):
		return true
	else:
		return false
	
