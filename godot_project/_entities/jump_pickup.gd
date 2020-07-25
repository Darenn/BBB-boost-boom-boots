extends Area2D

export(int) var jump_reward = 1
export(int) var score_reward = 10




func _on_jump_pickup_body_entered(body: Node) -> void:
	if body is Player:
		body.on_pickup_jump(jump_reward, score_reward)
	queue_free()
