extends Area2D

func _ready() -> void:
	connect("body_entered", self, "_on_bkill_body_entered")

func _on_bkill_body_entered(body: Node) -> void:
	if body is Player:
		body.die()
#		body.queue_free()
#		get_tree().reload_current_scene()
