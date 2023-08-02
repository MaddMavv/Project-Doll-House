extends Node

var boss = false;
var dead = false;

var playerHP = 4;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.playerHP <= 0:
		dead = true
		playerHP = 4;
