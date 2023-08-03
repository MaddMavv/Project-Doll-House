extends Node

var boss = false
var dead = false

var playerHP = 4



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.playerHP <= 0:
		dead = true
		await get_tree().create_timer(2).timeout
		playerHP = 4
