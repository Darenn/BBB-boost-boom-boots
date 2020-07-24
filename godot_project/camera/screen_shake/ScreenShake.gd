extends Node

class_name ScreenShake

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var _amplitude = 0
var _priority = 0

onready var _camera = get_parent()

# Start a screen shake for duration seconds
# frequency is how often it shakes per second
# amplitude is how far (strong) it will shake
# priority is how important this shake is compared to others
func start(duration = 0.2, frequency = 15, 
			amplitude = 16, priority = 0) -> void:
	if (priority >= self._priority):
		self._priority = priority
		self._amplitude = amplitude
		
		$Duration.wait_time = duration
		$Frequency.wait_time = 1 / float(frequency)
		$Duration.start()
		$Frequency.start()
		
		_new_shake()

func _new_shake() -> void:
	var rand = Vector2()
	rand.x = rand_range(-_amplitude, _amplitude)
	rand.y = rand_range(-_amplitude, _amplitude)

	$ShakeTween.interpolate_property(_camera, "offset", _camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _reset():
	$ShakeTween.interpolate_property(_camera, "offset", _camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()
	
	_priority = 0



func _on_Frequency_timeout() -> void:
	_new_shake()


func _on_Duration_timeout() -> void:
	_reset()
	$Frequency.stop()
