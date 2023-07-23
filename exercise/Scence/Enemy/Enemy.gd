extends KinematicBody2D
class_name Enemy

export(float) var gravity :int  = 1000
export(int) var walk_speed :int = 75

var velocity: Vector2
var input_direction_x: int = 0

var floor_max_angle = deg2rad(65)

var rng =RandomNumberGenerator.new()

enum states{
	IDLE,
	WALK,
	DEATH
}
var state = states.IDLE

func _ready() -> void:
	rng.randomize()
	$MoveTimer.start()
	
	
func _input(event):
	if event.is_action_pressed("ui_left"):
		input_direction_x = -1
	elif event.is_action_pressed("ui_down"):
		input_direction_x = 0
	elif event.is_action_pressed("ui_right"):
		input_direction_x = 1
	
	
func get_random_direction() -> int:
	var random_number = rng.randi_range(0, 2)
	return [-1, 0, 1][random_number]


func updata_direction(direction_x) -> void:
	if direction_x == 1 :
		$AnimatedSprite.flip_h = false
	elif direction_x == -1 :
		$AnimatedSprite.flip_h = true


func _physics_process(delta: float) -> void:
	match state:
			
		states.IDLE:
			$AnimatedSprite.play("Idle")
			if input_direction_x != 0: self.state = states.WALK
		
		states.WALK:
			$AnimatedSprite.play("Walk")
			updata_direction(input_direction_x)
			velocity = Vector2(walk_speed * input_direction_x , gravity * delta)
			velocity = move_and_slide_with_snap(
					velocity, Vector2.DOWN, Vector2.UP, true, 4, floor_max_angle, false)
			if abs(velocity.x) <= 0.1 :
				input_direction_x = 0
				self.state = states.IDLE
			# 这里其实不应该把判断逻辑放在Enemy里面
			if get_slide_count() > 0:
				for i in get_slide_count():
					var collision = get_slide_collision(i)
					var collider = collision.collider
					if collider is Player:
						# 这个地方就没设计好，Enemy不应该知道Player有Statement节点以及方法
						collider.get_node("StateMachine").transition_to("Death")
		
		states.DEATH:
			$AnimatedSprite.play("Death")
			$CollisionShape2D.disabled = true
			yield($AnimatedSprite, "animation_finished")
			queue_free()


func _on_MoveTimer_timeout() -> void: input_direction_x = get_random_direction()


func _on_HurtBox_area_entered(area: Area2D):
	# 此处只需要发出信号就行了
	if area.owner is Player:
		self.state = states.DEATH
	
