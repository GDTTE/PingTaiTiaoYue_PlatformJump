extends KinematicBody2D

class_name Player

onready var animation_state = get_node("AnimationTree").get("parameters/playback")

# temporary put in there
var gravity: = 800

# basic parameters
var walk_speed: float = 80
var jump_speed:float = 300
var dash_speed:float = 300

var floor_max_angle = deg2rad(65)
var current_velocity: Vector2
#var expect_velocity: Vector2 = Vector2.ZERO
var expect_direction: Vector2

var is_jumping = false
var is_attacking = false
var is_dashing = false
var dash_nums = 1

#onready var animation_state = get_node("/root/AnimationTree").get("parameters/playback")

var inputdirection_x

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

var state = states.WALK
	
func apply_gravity(delta:float)->void:
	current_velocity.y += delta * gravity


func update_flip(inputdirection_x)->void:
	if inputdirection_x>0:
		get_node("Sprite").flip_h = false
	if inputdirection_x < 0:
		get_node("Sprite").flip_h = true

func on_attack_finished():
	is_attacking = false
	print("on_attack_finished")

func on_dash_dinished():
	is_dashing = false
	print("on_dash_finished")
