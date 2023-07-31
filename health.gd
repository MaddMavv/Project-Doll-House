extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play("full")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.playerHP == 2:
		play("ow1")
	if Game.playerHP == 1:
		play("ow2")
	if Game.playerHP == 0:
		play("ow3")
	
