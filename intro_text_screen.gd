extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_continue_pressed():
	if $Textbox.done == true: 
		get_tree().change_scene_to_file("res://level_2.tscn")

func _on_skip_pressed():
	get_tree().change_scene_to_file("res://level_2.tscn")
		
	
