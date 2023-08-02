extends Control

var is_bottom_broken : bool = false
var is_left_broken : bool = false
var is_right_broken : bool = false

func _ready():
#    break_pieces($BottomHeart)
	pass


func _process(delta):
	if Game.playerHP == 3 and !is_right_broken:
		
		is_right_broken = true
	elif Game.playerHP == 2 and !is_left_broken:
		
		is_left_broken = true
	elif Game.playerHP == 1 and !is_bottom_broken:
		break_pieces($BottomHeart)
		is_bottom_broken = true
		

func break_pieces(parts : Node):
	for i in parts.get_children():
		i.freeze = false
		i.linear_velocity.x = randf_range(-1000, 1000)
		await get_tree().create_timer(0.05).timeout
