extends Camera2D

export(int) var vertical_speed = 500

func _process(delta: float) -> void:
	position += vertical_speed * Vector2.UP * delta
