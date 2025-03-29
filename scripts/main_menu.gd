extends Control

@export var next_scene: String

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(next_scene)


func _on_info_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Info.tscn")
