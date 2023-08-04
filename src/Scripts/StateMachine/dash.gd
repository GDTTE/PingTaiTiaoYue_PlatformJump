extends StateCommonCode



func enter()->void:
	player.animation_state.travel("dash")
	player.is_dashing = true
	player.dash_nums -= 1
	
	
func exit()->void:
	pass



func physics_update(delta)->void:
	player.current_velocity.y = 0
	if player.direction == "right":
		player.current_velocity.x = player.dash_speed
	else:
		player.current_velocity.x = -player.dash_speed
	
	player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
	if !player.is_dashing:
		if player.is_on_floor():
			state_machine.transition_to("idle")
		
		else:
			state_machine.transition_to("fall")
			
	













	
