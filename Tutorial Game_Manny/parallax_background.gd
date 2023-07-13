extends ParallaxBackground
#this is paralax background stuff, it would be how we do the shelf stuff, but I'm kinda lost atm

var scrolling_speed = 100

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta
