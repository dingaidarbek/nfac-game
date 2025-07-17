extends Node

func _ready():
	print("Генерация")
	for child in get_parent().get_children():
		if child is MeshInstance3D and child.mesh:
			var body = StaticBody3D.new()
			var shape = CollisionShape3D.new()
			var mesh_shape = child.mesh.create_trimesh_shape()
			if mesh_shape:
				shape.shape = mesh_shape
				body.add_child(shape)
				body.global_transform = child.global_transform
				get_parent().add_child(body)
