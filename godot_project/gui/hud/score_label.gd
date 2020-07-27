extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""
	yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")
	var count = 0
	var already_scored = []
	for score in SilentWolf.Scores.scores:
		if not already_scored.has(score.player_name):
			already_scored.append(score.player_name)
			text+= "%s %s\n" % [score.player_name, score.score]
		else:
			continue


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_end_trigger_body_entered(body: Node) -> void:
	pass

func _on_end_trigger_new_score() -> void:
	text = ""
	yield(SilentWolf.Scores.get_high_scores(0), "sw_scores_received")
	var count = 0
	var already_scored = []
	for score in SilentWolf.Scores.scores:
		if not already_scored.has(score.player_name):
			already_scored.append(score.player_name)
			text+= "%s %s\n" % [score.player_name, score.score]
		else:
			continue
