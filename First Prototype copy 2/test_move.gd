extends Node2D

var targetX
var radius = 200
var move = 0.01
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move += 0.01
	targetX = cos(move) * radius + 600
	position.x = targetX
	print(position.x)
