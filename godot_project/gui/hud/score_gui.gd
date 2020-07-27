extends CanvasLayer



func _ready() -> void:
	$news2/description.text = "WANTED CRIMINAL\n%s" % NameEntry.player_name


func _on_player_scored(score, combo) -> void:
	$big_news/score.text = "SCORE : %s" % score
	$big_news/combo.text  ="COMBO : x%s" % combo


func _on_line_edit_text_entered(new_text: String) -> void:
	$news2/description.text = "WANTED CRIMINAL\n%s" % NameEntry.player_name
