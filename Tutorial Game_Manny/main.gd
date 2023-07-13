extends Node2D



#makes the game quit
func _on_quit_pressed():
	get_tree().quit()

#changes the scene to the other scene when the button is pressed
func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
