extends Node2D

var targetX
var radius = 200
var move = Vector2(0, 0)
var velocity = Vector2(1, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move.x += velocity.x * delta
	targetX = cos(move.x) * radius + 600
	position.x = targetX
	print(position.x)
