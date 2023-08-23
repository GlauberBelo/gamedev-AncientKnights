extends Control

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))

func on_button_pressed(button_name: String) -> void:
	match button_name:
		"NewGame":
			get_tree().change_scene_to_file("res://management/level.tscn")
		"Quit":
			get_tree().quit()
