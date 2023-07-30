extends Entity

class_name Player

onready var animation_state = get_node("AnimationTree").get("parameters/playback")

func _ready():
	controller = PlayerController.new(self)
	
