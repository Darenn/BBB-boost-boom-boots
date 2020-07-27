extends Label


func _process(delta: float) -> void:
	rect_position -= Vector2(20, 0) * delta
