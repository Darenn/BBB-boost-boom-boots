extends Area2D


func _on_end_trigger_body_entered(body: Node) -> void:
	if body.name == "player":
		body.on_end()
		queue_free()
