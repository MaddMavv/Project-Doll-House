extends Node

var boss = false;

var playerHP = 4;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.playerHP <= 0:
		playerHP = 4;
		get_tree().change_scene_to_file("res://main menu.tscn")
