extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pong_double.tscn")


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu2.tscn")
