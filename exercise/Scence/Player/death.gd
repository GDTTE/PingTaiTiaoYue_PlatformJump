extends StateCommonCode




func enter():
	player.animation_state.travel("death")


func exit():
	pass
	
func physics_update(delta:float)->void:
	pass
