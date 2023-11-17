extends CanvasLayer
@onready var bgm = $BGM


# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()


func _on_button_restart_pressed():
	Global.score = 0
	get_tree().change_scene_to_file("res://scenes/Levels/Level_1.tscn")


func _on_button_quit_pressed():
	get_tree().quit()
