extends StateCommonCode



func enter()->void:
	player.animation_state.travel("idle")
	player.current_velocity = Vector2.ZERO
	player.is_jumping = false
	player.dash_nums = 1
	
func exit()->void:
	pass



func physics_update(delta)->void:
	var inputdirection_x =(
		Input.get_action_strength("right")-Input.get_action_strength("left")
			)

						
	
	player.apply_gravity(delta)
	player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
	if inputdirection_x!= 0:
		state_machine.transition_to("walk")
				
	if player.current_velocity.y >0:
		state_machine.transition_to("fall")
				
			
	if Input.is_action_just_pressed("jump"):
		if !player.is_jumping:
			state_machine.transition_to("jump")
	
	if Input.is_action_just_pressed("attack"):
		if !player.is_attacking:
			state_machine.transition_to("attack")
					
	if Input.is_action_just_pressed("dash"):
		if player.dash_nums >0 && !player.is_dashing:
			state_machine.transition_to("dash")













