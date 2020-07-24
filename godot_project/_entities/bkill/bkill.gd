extends Area2D

func _on_bkill_body_entered(body: Node) -> void:
	body.queue_free()
