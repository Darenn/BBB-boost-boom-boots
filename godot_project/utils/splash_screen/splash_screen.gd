class_name SplashScreen
extends Control
# Will display one after the other each SplashScreenItem child

export(PackedScene) var next_scene

func _ready() -> void:
	# Hide all items and position them in the center of the screen
	for item in get_children():
		if item is SplashScreenItem:
			item.visible = false
			item.position = get_viewport().size/2

	# Play each item one after the other
	for item in get_children():
		if item is SplashScreenItem:
			item.play()
			item.visible = true
			yield(item, "finished_play")
			item.visible = false
	
	get_tree().change_scene_to(next_scene)


func _input(event):
	if (event is InputEventKey or event is InputEventJoypadButton) and event.pressed:
		get_tree().change_scene_to(next_scene)

