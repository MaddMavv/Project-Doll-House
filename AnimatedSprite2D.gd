extends AnimatedSprite2D

func _ready() -> void:
	
	var instanceObject = SpriteFrameResource.new()
	var framestuff = instanceObject.getFrames()
	var name: String = instanceObject.name #play
	
	self.set_sprite_frames(framestuff)
	self.play(name)
