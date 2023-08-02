extends Control

var is_bottom_broken : bool = false
var is_left_broken : bool = false
var is_right_broken : bool = false

func _ready():
#	break_pieces($BottomHeart)
	pass


func break_pieces(parts : Node):
	for i in parts.get_children():
		i.freeze = false
		i.linear_velocity.x = randf_range(-1000, 1000)
		await get_tree().create_timer(0.05).timeout
