extends AudioStreamPlayer


export(AudioStream) var music


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func play_music() -> void:
	stop()
	stream = music
	play()
