class_name Player
extends KinematicBody2D

export(int) var jump_speed = 1000
export(int) var vertical_speed = 500

var _direction = Vector2.RIGHT
var _is_jumping = false


func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if _is_jumping:
		if move_and_collide(jump_speed * _direction * delta):
			_is_jumping = false
	if Input.is_action_just_pressed("jump"):
		_jump()
		
func _physics_process(_delta: float) -> void:
	move_and_slide(vertical_speed * Vector2.UP)
	
func _jump() -> void:
	_direction = -_direction
	_is_jumping = true
	
