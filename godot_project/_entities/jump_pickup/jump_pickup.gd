extends Area2D

export(int) var jump_reward = 0
export(int) var score_reward = 10

const score_explosion = preload("res://effects/score_explosion/score_explosion.tscn")

func _ready() -> void:
	pass
#	$Sprite.frame = randi() % 7

func _on_jump_pickup_body_entered(body: Node) -> void:
	if body is Player:
		body.on_pickup_jump(jump_reward, score_reward)
		var instance = score_explosion.instance()
		get_tree().get_root().get_node("main").add_child(instance)
		instance.rect_position = global_position + Vector2(0, -10)
		queue_free()
