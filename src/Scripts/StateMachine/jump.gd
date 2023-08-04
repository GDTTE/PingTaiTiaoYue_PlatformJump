extends StateCommonCode



func enter()->void:
	print("inter jump process")
	player.animation_state.travel("jump")
	player.current_velocity.y = -player.jump_speed
	player.is_jumping = true
	
	
func exit()->void:
	pass



func physics_update(delta)->void:
	var inputdirection_x =(
		Input.get_action_strength("right")-Input.get_action_strength("left")
			)
	player.update_flip(inputdirection_x)
			
	player.apply_gravity(delta)
			
	player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
	player.current_velocity.x = inputdirection_x * player.walk_speed
			
			
	if player.current_velocity.y >0 :
		state_machine.transition_to("fall")
			
	if Input.is_action_just_pressed("attack"):
		if !player.is_attacking:
			state_machine.transition_to("attack")
					
	if Input.is_action_just_pressed("dash"):
		if player.dash_nums >0:
			player.dash_nums -= 1
			state_machine.transition_to("dash")
