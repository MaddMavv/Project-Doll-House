extends CanvasLayer

@onready var textbox_container = $Container
@onready var thanks = $Container/HBoxContainer/thanks


func _ready():
	pass 


func _process(_delta):
	text_animation()
	
func text_animation():
	var tween = get_tree().create_tween().bind_node(self)
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	thanks.visible_ratio = 0
	tween.tween_property(thanks, "visible_ratio", 1.0, 1)
