extends CanvasLayer

@onready var textbox_container = $Container
@onready var start_symbol = $Container/HBoxContainer/Start
@onready var end_symbol = $Container/HBoxContainer/End
@onready var theText = $Container/HBoxContainer/theText
const readSpeed = 0.05

func _ready():
	hide_textbox()
	add_text("This is the text!")

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	theText.text = ""
	textbox_container.hide()


func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func add_text(next_text):
	theText.text = next_text
	show_textbox()
	theText.visible_ratio = 0
	var tween = get_tree().create_tween()
	tween.tween_property(theText, "visible_ratio", 1.0, 1.5)
	await tween.finished
	
