extends AnimatedSprite

func _ready() -> void:
	play()


func _on_jump_explosion_animation_finished() -> void:
	queue_free()
