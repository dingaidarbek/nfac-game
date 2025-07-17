extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 10.0
@export var mouse_sensitivity = 0.1

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity * 0.01)
		head.rotate_x(-event.relative.y * mouse_sensitivity * 0.01)
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, -90, 90)

func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	move_and_slide()
