extends Control

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))

func on_button_pressed(button_name: String) -> void:
	match button_name:
		"NewGame":
			transition_screen.scene_path = "res://management/level.tscn"
			transition_screen.fade_in()
		"Quit":
			transition_screen.can_quit = true
			transition_screen.fade_in()
