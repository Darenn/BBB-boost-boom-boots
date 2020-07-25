extends Camera2D

export(int) var vertical_speed = 500
export(float) var shake_duration = 0.2
export(int) var shake_frequency = 15
export(int) var shake_amplitude = 16

func _process(delta: float) -> void:
	position += vertical_speed * Vector2.UP * delta
	
	
func shake():
	$screen_shake.start(shake_duration, shake_frequency, shake_amplitude)
