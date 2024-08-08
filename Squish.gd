extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Squish"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	pass

func get_input():
	var speed = 5
	var input_direction = Input.get_vector("left", "right", "up", "down")
	$Head.apply_impulse(input_direction * 2*speed,Vector2(0,0))
	
	if Input.is_action_just_pressed('ui_accept'):
		$Base.apply_impulse(Vector2(0,-16*4))
