extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Constant
var bounces = 3
var jump_force = -250.0
var spring_constant = 100.0
var damping = 5.0
var compression_speed = 4.5
var max_compression = 0.8
var rest_height = 1.0
# Variables
var is_compressing = false
var is_jumping = false
var is_decompressing = false
var compression = 0.0

func _ready():
	name = "Squish"
	pass

func _physics_process(delta):
	get_input()
	handle_bounce(delta)
	handle_compression(delta)
	update_spring_visual()
	if bounces == 0:
		if $CanJump.is_colliding():
			bounces = 7
			velocity -= velocity * 0.25
	#move_and_slide()

func handle_bounce(delta):
	var collison = move_and_collide(velocity * delta)
	if collison:
		if not Input.is_action_pressed("ui_select") and bounces >0:
			bounces -=1
			print('collision',min(SPEED/velocity.y,1))
			compression = min( 1,max(SPEED/velocity.y,0))
			is_decompressing = true
			velocity.y -= velocity.y*(bounces/10)
			jump_force -= jump_force * 0.2
			var reflect = collison.get_remainder().bounce(collison.get_normal())
			velocity = velocity.bounce(collison.get_normal()) 
			print(reflect)
			move_and_collide(reflect)
		
			
					
#f = -k * (x -d) - b * v
#force = -stiffness * (currentLength - restLength) - damping * velocity
func handle_compression(delta):
	if is_compressing:
		# Compress the spring
		compression += compression_speed * delta
		print(velocity.y)
		velocity.y +=  0.1
		print(velocity.y)
		if compression >= max_compression:
			compression = max_compression
			is_compressing = false
			#is_jumping = true
	elif is_decompressing:
		# Decompress the spring
		compression -= (compression_speed ** max_compression) * delta
		if compression <= 0:
			compression = 0
			is_decompressing = false
			perform_jump()
	else:
		# Apply gravity if not on the floor
		if not $CanJump.is_colliding():
			velocity.y += gravity *1.2 * delta
			
func perform_jump():
	if $CanJump.is_colliding():
		print('i jumped',jump_force)
		velocity.y = jump_force
		max_compression = 0.9 
	
func update_spring_visual():
	# Scale the sprite based on the compression
	$Icon.scale = Vector2(rest_height+compression/2,rest_height - compression)
	$Sprite.scale = Vector2(rest_height+compression/2,rest_height - compression)
	
func get_input():
	if Input.is_action_just_pressed("ui_select") and not is_compressing and not is_jumping:
		#if not $CanJump.is_colliding():
			#velocity.y = move_toward(velocity.y,0,SPEED)
		is_compressing = true
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_released("ui_select"):
		print(1+compression)
		jump_force = JUMP_VELOCITY * (1+compression)
		max_compression = compression if not compression == 0 or compression >=1.0 else 0.8
		is_decompressing = true



func _on_area_2d_body_entered(body):
	print(body.name)
	if(body.name == 'Squish'):
		print('you won')
		$YouWin.show()
	pass # Replace with function body.

