extends Area2D
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var game_win = $GameWin



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	Global.player_freeze(body)
	game_win.play()
	await(game_win.finished)
	get_tree().change_scene_to_file("res://scenes/game_win_screen.tscn")
