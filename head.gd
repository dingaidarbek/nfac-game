extends CharacterBody3D

@export var mouse_sensitivity := 0.002
var head

func _ready():
	head = $Head
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, -90, 90)
