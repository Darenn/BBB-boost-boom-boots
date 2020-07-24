class_name SplashScreenItem
extends Node2D
# An item to display during the SplashScreen
# You should inherit from this class and implement the play method if you want
# a custom behaviour.
# Don't forget to emit the "finished_play" signal

signal finished_play


func play() -> void:
	$AnimationPlayer.play("splash")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("finished_play")
