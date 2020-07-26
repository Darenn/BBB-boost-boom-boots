extends Label





func _on_player_scored(score, combo) -> void:
	text = "Score : %s" % score
	$combo.text  ="x%s" % combo
	$animation_player.play("bounce")
