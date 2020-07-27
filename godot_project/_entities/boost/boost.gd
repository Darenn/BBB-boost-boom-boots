extends Area2D

export(int) var score_reward = 10
export(int) var speed_boost = 50
export(int) var jump_boost = 10

const score_explosion = preload("res://effects/score_explosion/score_explosion.tscn")
const landing_effect = preload("res://effects/landing_effect/landing_effect.tscn")

func _ready() -> void:
	connect("body_entered", self, "_on_jump_pickup_body_entered")
	$animation_player.play("glow")

func _on_jump_pickup_body_entered(body: Node) -> void:
	if body is Player:
		body.on_boost_jump(speed_boost, jump_boost, score_reward)
		var instance = score_explosion.instance()
		get_tree().get_root().get_node("main").add_child(instance)
		instance.rect_position = global_position + Vector2(0, -32)
		var combo: int = get_tree().get_root().get_node("main/player").combo
		var res = score_reward * combo
		instance.text = "+%s" % res
		
		var inst = landing_effect.instance()
		get_tree().get_root().get_node("main").add_child(inst)
		inst.global_position = global_position
		inst.modulate = Color.yellow
		inst.amount = 10
		inst.initial_velocity /= 2
		
#		SlowTimeEffect.start(0.1, 0.5)
		
		queue_free()

