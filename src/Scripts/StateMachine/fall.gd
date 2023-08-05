extends StateCommonCode



func enter()->void:
	
	player.animation_state.travel("fall")
	
	
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
	
	
#	if player.get_slide_count() > 0:
#		for i in range(player.get_slide_count()):
#			var collision = player.get_slide_collision(i)
#			var collider = collision.collider
#
#			if collider is Enemy:
#				#collision_normal = collision.normal
#				player.collider_direction = collider.direction
#				state_machine.transition_to("damaged")

	
	
	
	
	if player.is_on_floor():
		state_machine.transition_to("idle")
		
	if Input.is_action_just_pressed("attack"):
		if !player.is_attacking:
			state_machine.transition_to("attack")
		
	if Input.is_action_just_pressed("dash"):
		if player.dash_nums >0:
			player.dash_nums -= 1
			state_machine.transition_to("dash")
