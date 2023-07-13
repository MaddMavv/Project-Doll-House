extends Node2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed = 35
var chase = false
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chase == true:
		print("Player is in range")
	else:
		get_parent().set_progress(get_parent().get_progress() + speed * delta)

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
