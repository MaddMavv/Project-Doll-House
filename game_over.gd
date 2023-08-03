extends Node


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://level_2.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://main menu.tscn")
