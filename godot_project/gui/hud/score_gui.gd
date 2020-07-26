extends Label





func _on_player_scored(score) -> void:
	text = "Score : %s" % score
	$animation_player.play("bounce")
