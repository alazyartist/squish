extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Constants
var jump_force = -400.0
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
		
	if is_compressing:
		print("Compressing")
		print(compression)
	if is_jumping:
		print("is_jumping")
		print(compression)
		print(max_compression)
	if is_compressing:
		# Compress the spring
		compression += compression_speed * delta
		if compression >= max_compression:
			compression = max_compression
			is_compressing = false
			#is_jumping = true
	elif is_decompressing:
		# Decompress the spring
		compression -= compression_speed * delta
		if compression <= 0:
			compression = 0
			is_decompressing = false
			perform_jump()
	else:
		# Apply gravity if not on the floor
		if not is_on_floor():
			velocity.y += gravity * delta

	# Move the character
	move_and_slide()

	# Update the spring's visual representation
	update_spring_visual()

func perform_jump():
	velocity.y = jump_force
	max_compression = 0.99 
	
func update_spring_visual():
	# Scale the sprite based on the compression
	$Icon.scale = Vector2(rest_height+compression/2,rest_height - compression)

func _input(event):
	if event.is_action_released("ui_select"):
		print(1+(1-compression))
		jump_force = JUMP_VELOCITY * (1+compression)
		max_compression = compression if not compression == 0 or compression >=1.0 else 0.8
		is_decompressing = true

	if event.is_action_pressed("ui_select") and is_on_floor() and not is_compressing and not is_jumping:
		is_compressing = true
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
