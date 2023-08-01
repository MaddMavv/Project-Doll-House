extends Sprite2D


var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../BarB")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.Camera2D.position
