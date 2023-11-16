extends Area2D
@onready var getting_impaled = $GettingImpaled

func _on_body_entered(body):
	body.animated_sprite_2d.visible = false
	body.collision_shape_2d.disabled = true
	getting_impaled.play()
	await(getting_impaled.finished)
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
