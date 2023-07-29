extends AnimatedSprite2D


func _ready():
	play("full")


# This should be replaced with a signal
func _process(_delta):
	if Game.playerHP == 2:
		play("ow1")
	if Game.playerHP == 1:
		play("ow2")
	if Game.playerHP == 0:
		play("ow3")

