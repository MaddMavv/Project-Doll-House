extends Label


# This should be replaced with a signal
func _process(_delta):
	text = "HP:" + str(Game.playerHP)
