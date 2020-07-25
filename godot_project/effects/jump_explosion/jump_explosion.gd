extends Area2D

func _ready() -> void:
	$animated_sprite.play()


func _on_animated_sprite_animation_finished() -> void:
	queue_free()


func _on_jump_explosion_area_entered(area: Area2D) -> void:
	if area is Destructible:
		area.destroy()
