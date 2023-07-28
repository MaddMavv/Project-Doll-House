extends Node2D

var targetX
var radius = 5000
var move = Vector2(0.00, 0)
var add = Vector2(0.02, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	targetX = sin(move.x) * radius * delta
	position.x = targetX
	move.x += add.x
	print(position.x)
	
