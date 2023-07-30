extends IController
class_name PlayerController


# temporary put in there
var gravity: = 1000

# basic parameters
var walk_speed: float = 80
var jump_speed:float = 300
var dash_speed:float = 300

var floor_max_angle = deg2rad(65)
var current_velocity: Vector2 = Vector2.ZERO
#var expect_velocity: Vector2 = Vector2.ZERO
var expect_direction: Vector2 = Vector2.ZERO

var is_jumping = false
var is_attacking = false
var dash_nums = 1

#onready var animation_state = get_node("/root/AnimationTree").get("parameters/playback")



enum states{
	IDLE,
	WALK,
	RUN,
	ATTACK,
	JUMP,
	FALL,
	DASH,
	DEATH
}

var state = states.IDLE

var input_direction := Vector2.ZERO


var player


func _init(body).(body) -> void:
	player = controlled
	add_component(WalkActor.new())
	
#	add_component(AttackActor.new())
#	add_component(JumpActor.new())
#	...
	self.capability_tag = "能够被玩家操纵 走路，攻击，跳跃"


func apply_gravity(delta:float)->void:
	current_velocity.y += delta * gravity





func input(event: InputEvent) -> void:
	input_direction.x = Input.get_axis("left","right")
	if event.is_action_pressed("jump"):
		input_direction.y = 1
	

func process(delta) -> void:
	(actors[0] as IActor).set_expect_direction(input_direction)
	match state:
		states.IDLE:
			apply_gravity(delta)
			player.animation_state.travel("idle")
			if  player.is_on_floor():
				dash_nums = 1
			
			if input_direction.x != 0:
				state = states.WALK
				return
			if input_direction.y >0:
				state = states.FALL
				return
			
			if Input.is_action_just_pressed("jump"):
				if !is_jumping:
					state = states.JUMP
					return
					
			if Input.is_action_just_pressed("attack"):
				if !is_attacking:
					state = states.ATTACK
					return
			
			
					
		states.WALK:
			var inputdirection_x:float =(
		Input.get_action_strength("right")-Input.get_action_strength("left")
			)
			player.animation_state.travel("walk")
			apply_gravity(delta)
			
			player.updata_flip()
			
			current_velocity =player.move_and_slide_with_snap(current_velocity,
																Vector2.DOWN,
																Vector2.UP,
																true,
																4,
																floor_max_angle,
																false)
			
			
			if Input.is_action_just_pressed("jump"):
				if !is_jumping:
					state = states.JUMP
					return
			
			
		
			
			if is_equal_approx(current_velocity.x, 0.0):
				state = states.IDLE
				return
			
		
		states.JUMP:
			is_jumping = true
			current_velocity.y = -jump_speed

func physics_process(delta) -> Vector2:
	return (actors[0] as IActor).act(delta)
