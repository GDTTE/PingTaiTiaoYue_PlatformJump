extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Owner : test
# Called when the node enters the scene tree for the first time.
func _ready():
	
	Owner = owner as test
	
	assert(Owner!= null)
	print(Owner.name)
	
