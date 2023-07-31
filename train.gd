extends CharacterBody2D

var SPEED = 900000
var direction = -1
var pog = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	if Game.boss == true:
		direction = 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = direction * SPEED * delta

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "byeTrain":
		queue_free();
	if body.is_in_group("BarB"):
		body.TRAIN()
