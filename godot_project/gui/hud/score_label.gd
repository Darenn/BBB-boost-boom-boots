extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "\n\n"
	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	for score in SilentWolf.Scores.scores:
		text+= "%s %s\n" % [score.player_name, score.score]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
