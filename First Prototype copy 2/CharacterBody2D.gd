extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_down"):
		velocity.x = 800;
	if Input.is_action_just_released("ui_down"):
		velocity.x = 0;
		
	velocity.y = 0;
	move_and_slide()
