extends LineEdit


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if NameEntry.player_name != "":
		self.queue_free()
	self.grab_focus()


func _on_line_edit_text_entered(new_text: String) -> void:
	if len(new_text) > 0:
		NameEntry.player_name = new_text
		self.queue_free()
