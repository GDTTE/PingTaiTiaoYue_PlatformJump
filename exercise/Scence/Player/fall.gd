extends StateCommonCode






func enter()->void:
	player.animation_state.travel("fall")
	

func exit()->void:
	pass
	

func physics_update(delta:float)->void:
	player.apply_gravity(delta)
	
	player.velocity = player.move_and_slide_with_snap(player.velocity,
													player.snap_vector,
													Vector2.UP,
													true,
													4,
													player.floor_max_angle,
													false)

	var inputdirection_x:float = (
		Input.get_action_strength("right")- Input.get_action_strength("left")
	)
	
	player.update_direction(inputdirection_x)
	
	player.velocity.x = player.walk_speed * inputdirection_x
	
	
	
	if player.is_on_floor():
		state_machine.transition_to("idle")
		return
	
	
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("attack")
		return


	if Input.is_action_just_pressed("dash"):
		if player.num_dashes > 0: 
			state_machine.transition_to("dash")
			return
