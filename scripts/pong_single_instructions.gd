extends Control


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/pong_single.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu3.tscn")
