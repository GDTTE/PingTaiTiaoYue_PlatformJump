extends KinematicBody2D

class_name Player

onready var animation_state = get_node("AnimationTree").get("parameters/playback")

# temporary put in there
var gravity: = 600

# basic parameters
var walk_speed: float = 75
var jump_speed:float = 200
var dash_speed:float = 200

var floor_max_angle = deg2rad(65)
var current_velocity: Vector2
var damaged_velocity: Vector2
#var expect_velocity: Vector2 = Vector2.ZERO
var expect_direction: Vector2

var is_jumping = false
var is_attacking = false
var is_dashing = false
var dash_nums = 1
var being_damaged = false

#onready var animation_state = get_node("/root/AnimationTree").get("parameters/playback")

var inputdirection_x
var direction = "right" 
var collider_direction:String


enum states{
	IDLE,
	WALK,
	RUN,
	ATTACK,
	JUMP,
	FALL,
	DASH,
	DEATH,
	DAMAGED
}

var state = states.WALK
onready var PHBar  = get_node("../PlayerHealthBar")
var player_max_health = 100
	
func _ready():
	get_node("HitboxPosition/Hitbox/CollisionShape2D").disabled = true
	PHBar.value = player_max_health
	
	
func apply_gravity(delta:float)->void:
	current_velocity.y += delta * gravity


func update_flip(inputdirection_x)->void:
	if inputdirection_x>0:
		direction = "right"
		get_node("Sprite").flip_h = false
		get_node("HitboxPosition/Hitbox").rotation_degrees = 0
	if inputdirection_x < 0:
		direction = "left"
		get_node("Sprite").flip_h = true
		get_node("HitboxPosition/Hitbox").rotation_degrees = 180

func on_attack_finished():
	is_attacking = false
	print("on_attack_finished")

func on_dash_finished():
	is_dashing = false
	print("on_dash_finished")
	
func on_damaged_finished():
	being_damaged = false

func resolve_damaged(collider_direction:String):
	PHBar.value -= 10
	
	if direction == "right":
		if direction == collider_direction:
			damaged_velocity = Vector2(100,-200)
		else:
			damaged_velocity = Vector2(-100,-200)
	else:
		if direction == collider_direction:
			damaged_velocity = Vector2(-100,-200)
		else:
			damaged_velocity = Vector2(100,-200)
