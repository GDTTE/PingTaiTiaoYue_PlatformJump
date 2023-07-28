extends KinematicBody2D
class_name SpikePit




var grivity = 1000
var is_stuck:bool = true
onready var raycast2d = get_node("RayCast2D")
var velocity:Vector2

func _physics_process(delta)->void:
	if !is_stuck :
		apply_grivity(delta)
		velocity = move_and_slide(velocity,Vector2.UP)
	
	if raycast2d.is_colliding():
		if raycast2d.collide_with_bodies == true:
			var collider = raycast2d.get_collider()
			if collider is Player:
				is_stuck = false	
		
		
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var collider = collision.collider
			if collider is Player:
				collider.get_node("StateMachine").transition_to("death")
		
		
		
		
		
		
func apply_grivity(delta:float)->void:
	velocity.y += grivity * delta
