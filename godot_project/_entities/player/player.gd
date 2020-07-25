class_name Player
extends KinematicBody2D

signal scored(score)
signal jumped
signal landed

export(int) var jump_speed = 1000
export(int) var vertical_speed = 500
export(int) var starting_jump_count = 3
export(int) var max_jump_count = 3
export(float) var jump_slow_motion_duration = 0.2
export(float) var jump_slow_motion_strength = 0.9
const jump_explosion_scene = preload("res://effects/jump_explosion/jump_explosion.tscn")

var score = 0

var _direction = Vector2.RIGHT
var _is_jumping = false


onready var _jump_count = max_jump_count 


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if _is_jumping:
		if move_and_collide(jump_speed * _direction * delta):
			_is_jumping = false
			emit_signal("landed")
			
	if Input.is_action_just_pressed("jump"):
		_jump()
		
	$Label.text = str(_jump_count)
	if _jump_count == 0:
		$Sprite.modulate = Color.orange
	else:
		$Sprite.modulate = Color.green


func _physics_process(_delta: float) -> void:
	move_and_slide(vertical_speed * Vector2.UP)

func on_pickup_jump(jump_reward: int, score_reward: int) -> void:
	_jump_count = min(_jump_count + jump_reward, max_jump_count)
	score += score_reward
	emit_signal("scored", score)
	
func on_destroying_destructibles(score_reward: int) -> void:
	score += score_reward
	emit_signal("scored", score)

func _jump() -> void:
	if _jump_count > 0:
		_direction = -_direction
		_is_jumping = true
		_jump_count -= 1
		emit_signal("jumped")
		var jump_explosion_instance = jump_explosion_scene.instance()
		get_tree().get_root().get_node("main").add_child(jump_explosion_instance)
		jump_explosion_instance.position = position
		SlowTimeEffect.start(jump_slow_motion_duration, jump_slow_motion_strength)
	else:
		pass #todo engine sound
		
