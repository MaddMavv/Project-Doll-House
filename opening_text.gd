extends CanvasLayer

@onready var textbox_container = $Container
@onready var start_symbol = $Container/HBoxContainer/Start
@onready var end_symbol = $Container/HBoxContainer/End
@onready var theText = $Container/HBoxContainer/theText
const readSpeed = 2

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []


func _ready():
	print("Starting state is ready")
	#hide_textbox()
	queue_text("Damaged vintage doll Barbara Scarlett is the newest addition to an indie shop that fixes and sells used toys.")
	queue_text("While undergoing repairs, Barb overhears the manager arguing over the store’s debt and imminent closure.")
	queue_text("The fate of the toys is uncertain.")
	queue_text("That night, Barb makes for the main display.")
	queue_text("She's actually a rare and valuable doll, and even with an impaired arm she knows she is worth enough to save the store.")
	queue_text("But the other toys don’t believe her. Acting on the orders of Gillian, a robot figure and apparent leader of the shelves, they imprison Barb in her packaging.")
	queue_text("The determined and pissed off doll severs her arm to escape confinement. She's spotted by a sentinel who alerts the store.")
	queue_text("She quickly knocks him out and takes his megaphone.")
	queue_text("Time to go loud.")
	queue_text("Barb jams the megaphone into her shoulder in place of her second arm. A single sound burst is enough to launch her to greater heights and stun enemies.")
	queue_text("If they won’t listen to her, she’ll just have to make them.")
	
	
func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("jump"):
				theText.visible_ratio = 1.0
		State.FINISHED:
			if Input.is_action_just_pressed("jump"):
				change_state(State.READY)
				theText.visible_ratio = 0
func queue_text(next_text):
	text_queue.push_back(next_text)


#func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	theText.text = ""
	textbox_container.hide()


#func show_textbox():
	start_symbol.text = ""
	textbox_container.show()
	
	
func display_text():
	var next_text = text_queue.pop_front()
	theText.text = next_text
	text_animation()
	change_state(State.READING)
	#show_textbox()
	
	
	
func text_animation():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(theText, "visible_ratio", 1.0, readSpeed)
	await tween.finished
	change_state(State.FINISHED)


func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing to ready")
		State.READING:
			print("to reading")
		State.FINISHED:
			print("to fin")
