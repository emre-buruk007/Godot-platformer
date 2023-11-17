extends Node2D
@onready var bgm_level_2 = $BGMLevel2



# Called when the node enters the scene tree for the first time.
func _ready():
	bgm_level_2.play()
