extends Label


func _ready() -> void:
	var pl = get_tree().get_root().get_node("main/player")
	$RandomAudioStreamPlayer2D.pitch_scale = 0.8 + (pl.combo * 0.01)
	$RandomAudioStreamPlayer2D.play()
#	yield($RandomAudioStreamPlayer2D, "finished")
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()


