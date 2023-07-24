extends StateCommonCode



func enter()->void:
	player.animation_state.travel("idle")
	
	
func exit()->void:
	pass

func physics_update()->void:
	if !player.is_on_floor() && player.velocity.y >0:
		state_machine.transition_to("fall")
	var inputdirection_x:float = Input.get_action_strength("right")
