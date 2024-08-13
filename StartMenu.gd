extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	PhysicsServer2D.set_active(true)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$%Label.text = str($"/root/Global".total_bounces)
	pass


func _on_start_pressed():
	print('start pressed')
	get_tree().paused = false
	hide()
	pass # Replace with function body.
