class_name Player
extends KinematicBody2D

signal scored(score, combo)
signal jumped
signal landed
signal started_climbing
signal died

export(int) var jump_speed = 1000
export(int) var vertical_speed = 500
export(int) var fall_speed = 10
export(int) var starting_jump_count = 3
export(int) var max_jump_count = 2
export(float) var jump_slow_motion_duration = 0.05
export(float) var jump_slow_motion_strength = -0.05
export(float) var time_combo = 1
const jump_explosion_scene = preload("res://effects/jump_explosion/jump_explosion.tscn")
const landing_effect = preload("res://effects/landing_effect/landing_effect.tscn")

var score = 0
var combo = 1

var _direction = Vector2.RIGHT
var _is_jumping = false
var _is_climbing = false
var _is_dead = false


onready var _vertical_speed = vertical_speed
onready var _jump_count = max_jump_count 


func _ready() -> void:
	$Sprite.speed_scale = 0.3
	$Sprite.play("idle")
#	$AnimationPlayer.play("idle", -1, 0.5)


func _process(delta: float) -> void:
	if _is_jumping:
		if _direction == Vector2.LEFT:
			$Sprite.flip_v = false
		else:
			$Sprite.flip_v = true
		var collision:KinematicCollision2D = move_and_collide(jump_speed * _direction * delta)
		if collision and not _is_dead:
			_is_jumping = false
			
			if _direction == Vector2.LEFT:
				$Sprite.flip_v = true
			else:
				$Sprite.flip_v = false
			
			play_anim_land()
#			$AnimationPlayer.play("run", -1, 1)
			$Sprite.rotation_degrees = -90
			$LandingAudioPlayer.play()
			
			_jump_count = max_jump_count
			
			var inst = landing_effect.instance()
			get_tree().get_root().get_node("main").add_child(inst)
			inst.global_position = collision.position
			inst.modulate = Color(0.5, 0.5, 0.5)
			SlowTimeEffect.start(0.2, 0.5)
			emit_signal("landed")
			
	if Input.is_action_just_pressed("jump") and len(NameEntry.player_name) > 0:
		if not _is_climbing:
			emit_signal("started_climbing")
			_is_climbing = true
			_is_dead = false
			$Sprite.flip_h = false
		_jump()
		
	$Label.text = str(_jump_count)
#	if _jump_count == 0:
#		$Sprite.modulate = Color.orange
#	else:
#		$Sprite.modulate = Color.green

func _unhandled_input(event):
	if event is InputEventScreenTouch and len(NameEntry.player_name) > 0:
		if event.pressed:
			if not _is_climbing:
				emit_signal("started_climbing")
				_is_climbing = true
				_is_dead = false
				$Sprite.flip_h = false
			_jump()


func _physics_process(_delta: float) -> void:
	if (_is_climbing):
		move_and_slide(vertical_speed * Vector2.UP)
	elif _is_dead:
		move_and_slide(fall_speed * Vector2.DOWN)

func on_pickup_jump(jump_reward: int, score_reward: int) -> void:
	_jump_count = min(_jump_count + jump_reward, max_jump_count)
	score += score_reward * combo
	combo += 1
	_scored_since_last_stop_combo = true
	emit_signal("scored", score, combo)
	
func on_destroying_destructibles(score_reward: int) -> void:
	score += score_reward * combo
	combo += 1
	_scored_since_last_stop_combo = true
	emit_signal("scored", score, combo)
	
func on_boost_jump(jump_speed, score_reward) -> void:
	score += score_reward * combo
	combo += 1
	vertical_speed += jump_speed
	_vertical_speed += jump_speed
	_scored_since_last_stop_combo = true
	$BoostPlayer.play()
	emit_signal("scored", score, combo)
	
var _scored_since_last_stop_combo = false
	
func stop_combo():
	_scored_since_last_stop_combo = false
	yield(get_tree().create_timer(time_combo), "timeout")
	if not _scored_since_last_stop_combo:
		combo = 0

func _jump() -> void:
	if _jump_count > 0:
		_direction = -_direction
		_jump_count -= 1 #NO REALLY YOU SHOULD NOPT

		play_anim_jump()
		$JumpAudioPlayer.play()
		$Sprite.modulate = Color.white
		
		emit_signal("jumped")
		
		var jump_explosion_instance = jump_explosion_scene.instance()
		get_tree().get_root().get_node("main").add_child(jump_explosion_instance)
		jump_explosion_instance.position = position
		
		if not _is_jumping:
			pass
#			SlowTimeEffect.start(jump_slow_motion_duration, jump_slow_motion_strength)
		_is_jumping = true
	else:
		var jump_explosion_instance = jump_explosion_scene.instance()
		get_tree().get_root().get_node("main").add_child(jump_explosion_instance)
		jump_explosion_instance.position = position
		jump_explosion_instance.modulate = Color(0.2,0.2,0.2)
		jump_explosion_instance.scale = Vector2(0.5,0.5)
		$NoJumpAudioPlayer.play()

func play_anim_jump():
	$Sprite.speed_scale = 1.5
	$Sprite.play("jump")
	yield($Sprite, "animation_finished")
	$Sprite.speed_scale = 1
	$Sprite.play("fly")
	
func play_anim_land():
	$Sprite.speed_scale = 4
	$Sprite.play("landing")
	yield($Sprite, "animation_finished")
	$Sprite.speed_scale = 3
	$Sprite.play("run")
		
func die() -> void:
	if _is_dead:
		return
	$Sprite.flip_h = true
	combo = 1
	_is_dead = true
	_is_climbing = false
	_vertical_speed = fall_speed
	$Sprite.speed_scale = 1
	$Sprite.play("fly")
#	$AnimationPlayer.play("fly")
	$HurtAudioPlayer.play()
	# TODO cancel combo
	score -= 100
	score = max(0, score)
	SlowTimeEffect.start(1, 0.9)
	var old_color = $Sprite.modulate
	$tween.interpolate_property($Sprite, "modulate", Color(255,255,255), old_color, 0.1)
	$tween.start()
	emit_signal("scored", score, combo)
	emit_signal("died")
