extends AnimatedSprite2D
@export var delay: float = 0.0 

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(delay).timeout
	play('default')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
