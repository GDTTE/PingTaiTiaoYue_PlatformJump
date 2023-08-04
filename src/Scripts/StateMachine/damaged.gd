extends StateCommonCode



func enter()->void:
	player.animation_state.travel("damaged")
	player.being_damaged = true
	print("enter damaged process")
	player.resolve_damaged(player.collider_direction)
	player.current_velocity += player.damaged_velocity
	
	
func exit()->void:
	pass



func physics_update(delta)->void:
	
	print("in damaged process")
	var inputdirection_x =(
		Input.get_action_strength("right")-Input.get_action_strength("left")
			)
	
	
	
	player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
	player.current_velocity.x = player.walk_speed * inputdirection_x
#	player.current_velocity.x += player.damaged_velocity.x
#	player.current_velocity.y = player.damaged_velocity.y
	
	
	player.apply_gravity(delta)

	if !player.being_damaged:
		if player.is_on_floor():
			if inputdirection_x !=0:
				state_machine.transition_to("walk")
			else:
				state_machine.transition_to("idle")
		else:
			state_machine.transition_to("fall")

