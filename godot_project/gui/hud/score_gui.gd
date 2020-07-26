extends Label





func _on_player_scored(score, combo) -> void:
	text = "SCORE : %s" % score
	$combo.text  ="COMBO x%s" % combo
	$animation_player.play("bounce")
