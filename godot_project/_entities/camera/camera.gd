extends Camera2D

export(int) var vertical_speed = 500
export(float) var shake_duration = 0.1
export(int) var shake_frequency = 15
export(int) var shake_amplitude = 16

var _started_climbing = false

func _process(delta: float) -> void:
	if _started_climbing:
		position += vertical_speed * Vector2.UP * delta
	
	
func shake():
	$screen_shake.start(shake_duration, shake_frequency, shake_amplitude)


func _on_player_started_climbing() -> void:
	_started_climbing = true
