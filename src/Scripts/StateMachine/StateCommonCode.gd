extends Node

class_name StateCommonCode

var player: Player

var state_machine

func _ready():
	
	yield(owner,"ready")
	player = owner as Player
	
	assert(player != null)
