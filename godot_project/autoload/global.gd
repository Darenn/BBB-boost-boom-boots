extends Node

func _ready() -> void:
	SilentWolf.configure({
			  "api_key": "z3aA2M1Uwg9nNWkHpeP4W9WjHC4Fp4L24o7b7ro0",
			  "game_id": "score_jam_9",
			  "game_version": "0.2",
			  "log_level": 1
			})
	SilentWolf.configure_scores(
		{"open_scene_on_close": "res://utils/splash_screen/splash_screen.tscn"})
	
