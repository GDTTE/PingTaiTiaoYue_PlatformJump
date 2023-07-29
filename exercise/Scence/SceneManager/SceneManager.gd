extends CanvasLayer



var color_dark = Color(44,58,84,255)
var color_light = Color(187,196,213,255)


onready var startscene = load("res://Scence/UI/LogoScene.tscn")

func reset_ColorRect(anim):
	match anim:
		"DarkFade":
			get_node("ColorRect").color = color_dark
		
		"LightFade":
			get_node("ColorRect").color = color_light 

		"RestartFade":
			get_node("ColorRect").color = color_dark


func change_scene(target_scene,anim):
	reset_ColorRect(anim)
	get_node("AnimationPlayer").play(anim)
	
	get_tree().change_scene_to(target_scene)
	
func _ready():
	change_scene(startscene,"DarkFade")
	
	
