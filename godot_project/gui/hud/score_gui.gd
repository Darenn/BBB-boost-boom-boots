extends Label



func _ready() -> void:
	$name.text = NameEntry.player_name


func _on_player_scored(score, combo) -> void:
	text = "SCORE : %s" % score
	$combo.text  ="COMBO x%s" % combo
	$animation_player.play("bounce")


func _on_line_edit_text_entered(new_text: String) -> void:
	$name.text = new_text
