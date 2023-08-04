extends Node
class_name PlayerController




	
	
var inputdirection_x :float
var collision_normal:Vector2


var player

func _ready():
	print("PlayerController Ready")
	yield(owner,"ready")
	player = owner as Player
	assert(player != null)
	
	
	

	

func _process(delta) -> void:
	pass
	

func _physics_process(delta) -> void:
	inputdirection_x =(
		Input.get_action_strength("right")-Input.get_action_strength("left")
			)
			
	if player.get_slide_count() > 0:
				for i in range(player.get_slide_count()):
					var collision = player.get_slide_collision(i)
					var collider = collision.collider
					
					if collider is Enemy:
						collision_normal = collision.normal
						print(collision_normal)
						player.state = player.states.DAMAGED
	
	
	
	match player.state:
		
		player.states.IDLE:
			player.current_velocity = Vector2.ZERO
			player.is_jumping = false
			player.animation_state.travel("idle")
			player.apply_gravity(delta)
			player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
			
		
			
			if  player.is_on_floor():
				player.dash_nums = 1
			
			if inputdirection_x!= 0:
				player.state = player.states.WALK
				
			if player.current_velocity.y >0:
				player.state = player.states.FALL
				
			
			if Input.is_action_just_pressed("jump"):
				if !player.is_jumping:
					player.state = player.states.JUMP
					
					
			if Input.is_action_just_pressed("attack"):
				if !player.is_attacking:
					player.state = player.states.ATTACK
					
			if Input.is_action_just_pressed("dash"):
				if player.dash_nums >0 && !player.is_dashing:
					player.state = player.states.DASH
			
					
		player.states.WALK:
			player.animation_state.travel("walk")
			
			player.update_flip(inputdirection_x)
			
			
			#player.updata_flip()
			player.apply_gravity(delta)
			player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
			player.current_velocity.x = player.walk_speed * inputdirection_x
			
			if Input.is_action_just_pressed("jump"):
				if !player.is_jumping:
					player.state = player.states.JUMP
			
			if Input.is_action_just_pressed("attack"):
				if !player.is_attacking:
					
					player.state = player.states.ATTACK
					
			if Input.is_action_just_pressed("dash"):
				if player.dash_nums >0:
					
					player.state = player.states.DASH
			
			if !player.is_on_floor():
				player.state = player.states.FALL
		
			
			if is_equal_approx(player.current_velocity.x, 0.0):
				player.state = player.states.IDLE
				
			
		
		player.states.JUMP:
			player.animation_state.travel("jump")
			if !player.is_jumping:
				player.current_velocity.y = -player.jump_speed
			player.is_jumping = true
			player.update_flip(inputdirection_x)
			
			player.apply_gravity(delta)
			#player.updata_flip()
			player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
		
			player.current_velocity.x = inputdirection_x * player.walk_speed
			
			
			if player.current_velocity.y >0 :
				player.state = player.states.FALL
			
			if Input.is_action_just_pressed("attack"):
				if !player.is_attacking:
					
					player.state = player.states.ATTACK
					
	
					
			if Input.is_action_just_pressed("dash"):
				if player.dash_nums >0:
					
					player.dash_nums -= 1
					player.state = player.states.DASH
		
		
		player.states.FALL:
			player.animation_state.travel("fall")
			player.apply_gravity(delta)
			player.update_flip(inputdirection_x)
			#player.updata_flip()
			player.apply_gravity(delta)
			player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
		
			player.current_velocity.x = inputdirection_x * player.walk_speed
			
			if player.is_on_floor():
				player.state = player.states.IDLE
		
			if Input.is_action_just_pressed("attack"):
				if !player.is_attacking :
					
					player.state = player.states.ATTACK
		
					
			if Input.is_action_just_pressed("dash"):
				if player.dash_nums >0:
					
					player.dash_nums -= 1
					player.state = player.states.DASH
		
		
		player.states.ATTACK:
			player.is_attacking = true
			player.animation_state.travel("attack")
			player.current_velocity.y = 0
			
			yield(get_tree().create_timer(0.45),"timeout")
			player.is_attacking = false
			
			if !player.is_attacking:
				if player.is_on_floor():
					if inputdirection_x !=0:
						player.state = player.states.WALK
					else:
						player.state = player.states.IDLE
				else:
					player.state = player.states.FALL
		
		
		player.states.DASH:
			player.is_dashing = true
			
			player.animation_state.travel("dash")
			
			player.current_velocity.y = 0
			
			if !player.get_node("Sprite").flip_h :
				player.current_velocity.x = player.dash_speed
			else:
				player.current_velocity.x = -player.dash_speed
			if player.is_dashing:
				print(player.is_attacking)
				
			player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
			
			yield(get_tree().create_timer(0.25),"timeout")
			player.is_dashing = false
			if !player.is_dashing:
				if player.is_on_floor():
					if inputdirection_x !=0:
						player.state = player.states.WALK
					else:
						player.state = player.states.IDLE
				else:
					player.state = player.states.FALL
			
			
			
		player.states.DAMAGED:
			player.current_velocity = (collision_normal*500) as Vector2
			player.PHBar.value -= 1
			player.current_velocity = player.move_and_slide_with_snap(player.current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																player.floor_max_angle,
																false)
		
			if player.is_on_floor():
				if inputdirection_x !=0:
					player.state = player.states.WALK
				else:
					player.state = player.states.IDLE
			else:
				player.state = player.states.FALL
		
		
		
		player.states.DEATH:
			print("death")
