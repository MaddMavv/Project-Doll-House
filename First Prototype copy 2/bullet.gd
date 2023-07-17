extends Area2D

class_name Bullet

# @export makes it so anyone can change the speed in the editor.
# Also makes the variable available to other scripts.
@export var speed := 500.0

# Initializes a direction variable so when this bullet is instantiated, 
# there's a direction var that can be set.
var direction := Vector2.ZERO

# This uses Godot's "Groups" which can be set in the inspector for each node.
# I created a "Player" Group and added the Player node to it.
# When this script loads, the var player gets a reference to the Player
# so we can know their position.
@onready var player := get_tree().get_first_node_in_group("BarB")

func _ready():
	# This is just so the bullet sprite is rotated to face the player.
	# This fuction needs a Vector2 to know where to rotate the node towards.
	look_at(position + direction)


func _physics_process(delta):
	# Moves the bullet over time towards a direction with a certain speed.
	position += direction * speed * delta


func _on_body_entered(body):
	if body.name == "BarB":
		Game.playerHP -= 1
