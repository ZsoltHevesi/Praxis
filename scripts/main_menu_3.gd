extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pong_instructions_screen.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pong_single_instructions_screen.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu2.tscn")
