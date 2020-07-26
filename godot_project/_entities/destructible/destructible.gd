class_name Destructible
extends Area2D

export(int) var score_reward
const score_explosion = preload("res://effects/score_explosion/score_explosion.tscn")
const landing_effect = preload("res://effects/landing_effect/landing_effect.tscn")

var _is_destroyed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$animation_player.play("glowing")


func destroy() -> void:
	if _is_destroyed:
		return
	_is_destroyed = true
	get_tree().get_root().get_node("main/player").on_destroying_destructibles(score_reward)
	var instance = score_explosion.instance()
	get_tree().get_root().get_node("main").add_child(instance)
	instance.rect_position = global_position+ Vector2(0, -32)
	var combo: int = get_tree().get_root().get_node("main/player").combo
	var res = score_reward * combo
	instance.text = "+%s" % res
	$CollisionShape2D.set_deferred("disabled", true)
	$animation_player.stop()
	modulate = Color(0.2,0.2,0.2, 0.8)
	
	var inst = landing_effect.instance()
	get_tree().get_root().get_node("main").add_child(inst)
	inst.global_position = global_position
	inst.modulate = Color.green
	
#	queue_free()
