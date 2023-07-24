extends Node

class_name StateCommonCode

var state_machine = null

var player:Player

func _ready():
	
	player = owner as Player
	
	assert(player!=null)
