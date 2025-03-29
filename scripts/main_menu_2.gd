extends Control

func _on_motorskills_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu3.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
