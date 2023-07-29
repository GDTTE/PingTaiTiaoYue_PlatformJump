extends Node







export var next_scene: PackedScene

func _ready():
	get_node("Timer").wait_time = 2
	get_node("Timer").start()



func _on_Timer_timeout():
	SceneManager.change_scene(next_scene,"DarkFade")
