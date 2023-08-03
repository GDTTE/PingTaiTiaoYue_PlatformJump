extends KinematicBody2D

class_name Enemy

export(float) var gravity = 800
export(int) var walk_speed = 75

var velocity: Vector2
var direction: String = "right"
var input_direction_x

var snap_length: int = 2
var snap_direction: Vector2 = Vector2.DOWN
var snap_vector = snap_direction * snap_length
var floor_max_angle = deg2rad(65)

var rand_gen = RandomNumberGenerator.new()

var state
enum states{
	WALK,
	DEATH
}

func _ready() -> void:
	rand_gen.randomize()
	input_direction_x = 1
	state = states.WALK
	$MoveTimer.start()
	
	
func get_random_direction() -> int:
	var random_number = rand_gen.randi_range(0, 1)
	return [-1, 1][random_number]
	


func set_direction_right() -> void:
	direction = "right"
	$AnimatedSprite.flip_h = false
	
	
func set_direction_left() -> void:
	direction = "left"
	$AnimatedSprite.flip_h = true
	
	
func updata_direction(direction_x) -> void:
	if direction_x > 0 :
		set_direction_right()
	elif direction_x < 0 :
		set_direction_left()
	
	
func _physics_process(delta: float) -> void:
	match state:
		states.WALK:
			$AnimatedSprite.play("Walk")
			updata_direction(input_direction_x)
			velocity.x = walk_speed * input_direction_x
			#apply_gravity(delta)
#			velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true, 4, floor_max_angle, false)
			velocity = move_and_slide(velocity,Vector2.UP)
			print(velocity)
			if get_slide_count() > 0:
				for i in range(get_slide_count()):
					var collision = get_slide_collision(i)
					var collider = collision.collider
					if collider is Player:
						collider.PHBar.value -= 1
						velocity.y = -200
						print(velocity.y)
						collider.current_velocity.y = -200
						
						

		states.DEATH:
			$AnimatedSprite.play("Death")
			$CollisionShape2D.disabled = true
			yield($AnimatedSprite, "animation_finished")
			queue_free()
	

func apply_gravity(delta) -> void:
	velocity.y = gravity * delta


func _on_MoveTimer_timeout() -> void:
	input_direction_x = get_random_direction()


func _on_HurtBox_area_entered(area: Area2D):
	if area.owner is Player: state = states.DEATH
