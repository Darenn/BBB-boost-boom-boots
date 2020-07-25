class_name Destructible
extends Area2D

export(int) var score_reward


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func destroy() -> void:
	get_tree().get_root().get_node("main/player").on_destroying_destructibles(score_reward)
	queue_free()
