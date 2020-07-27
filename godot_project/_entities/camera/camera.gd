extends Camera2D

export(int) var vertical_speed = 500
export(int) var fall_speed = 10
export(float) var shake_duration = 0.1
export(int) var shake_frequency = 8
export(int) var shake_amplitude = 10

var _started_climbing = false
var _is_falling = false
onready var _player = get_tree().get_root().get_node("main").get_node("player")
onready var _offset_y = _player.global_position.y - global_position.y
onready var starting_pos = global_position

var game_over = false

func _process(delta: float) -> void:
	if not game_over:
		global_position.y = _player.global_position.y - _offset_y
#	if _started_climbing:
#		position += vertical_speed * Vector2.UP * delta
#	elif _is_falling:
#		position += fall_speed * Vector2.DOWN * delta
	
	
func shake():
	$screen_shake.start(shake_duration, shake_frequency, shake_amplitude)


func _on_player_started_climbing() -> void:
	_started_climbing = true


func _on_player_died() -> void:
	_started_climbing = false
	_is_falling = true



func _on_player_end() -> void:
	yield(get_tree().create_timer(5), "timeout")
	game_over = true
	$tween.interpolate_property(self, "global_position", global_position, starting_pos, 5)
	$tween.start()
