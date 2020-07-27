tool
extends EditorPlugin

func _enter_tree():
	pass

func _exit_tree():
	pass
	
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_M) and Input.is_key_pressed(KEY_CONTROL):
		var selected_nodes = get_editor_interface().get_selection().get_selected_nodes()
		for node in selected_nodes:
			if node is CanvasItem:
				node.position = node.get_global_mouse_position()
