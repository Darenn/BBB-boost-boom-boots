extends Area2D

export(int) var jump_reward = 0
export(int) var score_reward = 10

const score_explosion = preload("res://effects/score_explosion/score_explosion.tscn")
const landing_effect = preload("res://effects/landing_effect/landing_effect.tscn")

func _ready() -> void:
	connect("body_entered", self, "_on_jump_pickup_body_entered")
	$animation_player.play("glow")

func _on_jump_pickup_body_entered(body: Node) -> void:
	if body is Player:
		body.on_pickup_jump(jump_reward, score_reward)
		var instance = score_explosion.instance()
		get_tree().get_root().get_node("main").add_child(instance)
		instance.rect_position = global_position + Vector2(0, -10)
		
		var inst = landing_effect.instance()
		get_tree().get_root().get_node("main").add_child(inst)
		inst.global_position = global_position
		inst.modulate = Color.green
		inst.amount = 10
		inst.initial_velocity /= 2
		
		SlowTimeEffect.start(0.1, 0.5)
		
		queue_free()
