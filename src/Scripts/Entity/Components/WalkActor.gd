extends IActor
class_name WalkActor

# temporary put in there
var gravity: = 1000

# basic parameters
var move_speed: float = 80
var floor_max_angle = deg2rad(65)
var current_velocity: Vector2 = Vector2.ZERO
#var expect_velocity: Vector2 = Vector2.ZERO
var expect_direction: Vector2 = Vector2.ZERO


func _init() -> void:
	self.capability_tag = "能够走"

# override the act func, and there is the terminal implement
# 重载行动函数，实现走的功能
func act(delta: float) -> Vector2:
	if is_instance_valid(self.body):
		current_velocity = body.move_and_slide_with_snap(
			move_speed * expect_direction + Vector2(0, gravity * delta),
			Vector2.DOWN,Vector2.UP,
			true, 4, floor_max_angle, false)
	else: print("ERROR: BODY LOST !")
	return current_velocity

# 接受行动意愿
func set_expect_direction(dirc: Vector2) -> void: expect_direction = dirc
