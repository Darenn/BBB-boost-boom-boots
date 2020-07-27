extends CanvasLayer



func _ready() -> void:
	$big_news/name.text = "suspect : %s" % NameEntry.player_name


func _on_player_scored(score, combo) -> void:
	$big_news/score.text = "destruction : %s" % score
	$big_news/combo.text  ="popularity : x%s" % combo


func _on_line_edit_text_entered(new_text: String) -> void:
	$big_news/name.text = "suspect : %s" % new_text
