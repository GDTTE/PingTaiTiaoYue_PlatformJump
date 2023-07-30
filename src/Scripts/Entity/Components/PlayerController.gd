extends IController
class_name PlayerController

enum states{
	IDLE,
	WALK,
	RUN
}

var state = states.IDLE

var input_direction := Vector2.ZERO

func _init(body).(body) -> void:
	add_component(WalkActor.new())
	self.capability_tag = "能够被玩家操纵"


func input(event: InputEvent) -> void:
	input_direction.x = Input.get_axis("ui_left","ui_right")
	if event.is_action_pressed("ui_up"):
		input_direction.y = 1
	

func process(delta) -> void:
	(actors[0] as IActor).set_expect_direction(input_direction)
	match state:
		state.IDLE:
			if input_direction != Vector2.ZERO: state = states.WALK
	
		state.WALK:
			if controlled.velocity > 1 : state = states.RUN
			elif controlled.velocity < 0.1 : state = states.IDLE
		
		state.RUN:
			if controlled.velocity < 1 && controlled.velocity > 0.1: state = states.WALK
			elif controlled.velocity < 0.1 : state = states.IDLE

func physics_process(delta) -> Vector2:
	return (actors[0] as IActor).act(delta)
