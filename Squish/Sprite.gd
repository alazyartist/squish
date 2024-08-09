extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play('default')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action("left"):
		flip_h = true
	elif event.is_action("right"):
		flip_h = false
