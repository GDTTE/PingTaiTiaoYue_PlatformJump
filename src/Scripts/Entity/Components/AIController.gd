extends IController
class_name AIController

var expect_velocity := Vector2.ZERO

var rand_policy_delay := 1
var delay_timer: Timer
var rng = RandomNumberGenerator.new()

enum states{
	IDLE,
	WALK,
	DEATH
}


var state = states.IDLE

func _init(body).(body):
	rng.randomize()
	delay_timer = Timer.new()
	body.add_child(delay_timer)
	delay_timer.wait_time = rand_policy_delay
	delay_timer.autostart = true
	delay_timer.connect("timeout", self, "do")
	add_component(WalkActor.new())
	self.capability_tag = "能够随机移动"


func process(delta) -> void:
	match state:
		states.IDLE:
			#$AnimatedSprite.play("Idle")
			if expect_velocity.x != 0: state = states.WALK

		states.WALK:
			if abs(expect_velocity.x) <= 0.1 :
				expect_velocity.x = 0
				state = states.IDLE
			else:
				#$AnimatedSprite.play("Walk")
				pass
		
		state.DEATH:		
			#asprite.play("Death")
			pass
	(actors[0] as IActor).set_expect_direction(expect_velocity)

func do(): 
	expect_velocity.x = [-1,0,1][rng.randi_range(0,2)]
	

func physics_process(delta):
	print("AIController Physics Process")
