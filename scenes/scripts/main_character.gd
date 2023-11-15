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
	# As good practice, you should replace UI actions with custom gameplay actions.
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
		var is_stomping = (
			collider is Enemy and is_on_floor()
			and collision.get_normal().dot(Vector2.UP) > 0.5)
		
		# these are collisions with enemy that kill player 
		var deadly_collision = (
			collider is Enemy and 
			(collision.get_normal().dot(Vector2.RIGHT)> 0.1 or 
			collision.get_normal().dot(Vector2.LEFT)> 0.1 or
			collision.get_normal().dot(Vector2.DOWN)> 0.1) )
		
		if is_stomping:
			velocity.y = JUMP_VELOCITY / 2
			(collider as Enemy).die()
			
		elif deadly_collision:
			animated_sprite_2d.visible = false
			collision_shape_2d.disabled = true
			player_death.play()
			await(player_death.finished)
			get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
			break
	
	
	
	# logic to turn the sprite during movement
	var isLeft = velocity.x < 0
	animated_sprite_2d.flip_h = isLeft
