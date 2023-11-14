extends CanvasLayer
@onready var bgm = $BGM


# Called when the node enters the scene tree for the first time.
func _ready():
	# stop main music and play game over music
	#BackgroundMusic.stop() 
	bgm.play()



func _on_button_restart_pressed():
	Global.score = 0
	get_tree().change_scene_to_file("res://scenes/Levels/Level_1.tscn")


func _on_button_quit_pressed():
	get_tree().quit()
