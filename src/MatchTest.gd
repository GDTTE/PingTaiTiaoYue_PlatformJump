extends KinematicBody2D


var state = states.IDLE

enum states{
	IDLE,
	WALK,
	JUMP,
	FALL,
	DASH
}
func _ready():
	print("2323")


func _physics_process(delta):
	match state:
		states.IDLE:
			print("IDLE")
			if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
				state = states.WALK
		
		states.WALK:
			print("WALK")
			
