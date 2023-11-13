extends CharacterBody2D
class_name MainCharacter

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var enemy_kill_sfx = $enemy_dead
@onready var player_dead_sfx = $"../player_dead_sfx"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func player_dead():
	player_dead_sfx.play()
	queue_free()
	
func check_collectible():
	pass

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
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		var is_stomping = (
			collider is Enemy and is_on_floor()
			and collision.get_normal().dot(Vector2.UP) > 0.5)
		
		# these are collisions with enemy that kill player 
		var deadly_collision = (
			collider is Enemy and 
			(collision.get_normal().dot(Vector2.RIGHT)> 0.5 or 
			collision.get_normal().dot(Vector2.LEFT)> 0.5 or
			collision.get_normal().dot(Vector2.DOWN)> 0.5) )
		if is_stomping:
			velocity.y = JUMP_VELOCITY / 2
			enemy_kill_sfx.play()
			(collider as Enemy).die()
		elif deadly_collision:
			player_dead_sfx.play()
			player_dead()
	
	# logic to turn the sprite during movement
	var isLeft = velocity.x < 0
	animated_sprite_2d.flip_h = isLeft	
