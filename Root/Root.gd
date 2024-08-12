extends Node2D

@export var new_squish:PackedScene = preload("res://Squish/Squish2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_cancel'):
		get_tree().paused = true
		$StartMenu.show()
		
	if Input.is_action_just_pressed("one"):	
		$Squish.queue_free()
		await get_tree().create_timer(0.000001).timeout
		var squish = new_squish.instantiate()
		add_child(squish)
	pass


