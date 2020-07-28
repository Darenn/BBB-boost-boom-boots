extends Area2D

signal new_score

func _on_end_trigger_body_entered(body: Node) -> void:
	if body.name == "player" and not body._game_over:
		body.on_end()	
		$end_board/big.text = "%s you're the best! Lov U <3" % NameEntry.player_name
		$end_board/small.text = "SCORE: %s \n Can you do better?\n (PS: we love feedback)" % body.score
		yield(get_tree().create_timer(5), "timeout")
		emit_signal("new_score")
