extends AnimatedSprite2D

@onready var trampoline = $"."
@onready var trampoline_sfx = $TrampolineSFX
@onready var collision_shape_2d = $Area2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if collision_shape_2d.
	pass


func _on_area_2d_body_entered(body):
	trampoline.play()
	trampoline_sfx.play()
	body.velocity.y -= 1200
#	if trampoline.frame == 2:
#		trampoline.stop()
	
