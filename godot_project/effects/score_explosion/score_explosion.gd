extends Label


func _ready() -> void:
	$RandomAudioStreamPlayer2D.play()
	yield($RandomAudioStreamPlayer2D, "finished")
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
