extends Area2D

func _on_bkill_body_entered(body: Node) -> void:
	if body is Player:
		body.queue_free()
		get_tree().reload_current_scene()
