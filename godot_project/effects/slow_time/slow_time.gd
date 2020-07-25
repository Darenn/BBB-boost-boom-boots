class_name SlowTime
extends Node

const END_VALUE = 1

var _is_active = false
var _time_start: float
var _duration_ms: float
var _start_value: float

func start(duration=0.4, strength = 0.9):
	_time_start = OS.get_ticks_msec()
	_duration_ms = duration * 1000
	_start_value = 1 - strength
	Engine.time_scale = _start_value
	_is_active = true
	

func _process(_delta: float) -> void:
	if _is_active:
		var current_time = OS.get_ticks_msec() - _time_start
		var value = circl_ease_in(current_time, _start_value, END_VALUE, 
								 _duration_ms)
		if current_time >= _duration_ms:
			_is_active = false
			value = END_VALUE
		Engine.time_scale = value
		
		
# t: current time
# b: start value
# c: end value
# d: duration
func circl_ease_in(t, b, c, d):
	t /= d
	return -c * (sqrt(1 - t * t) - 1) + b
