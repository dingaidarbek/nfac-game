extends Node

func _ready():
	print("Генерация началась")
	var root = get_tree().current_scene
	for child in root.get_children():
		if child is MeshInstance3D and child.mesh:
			var shape = child.mesh.create_trimesh_shape()
			if shape == null:
				print("Не удалось создать коллизию для: ", child.name)
				continue
			var body = StaticBody3D.new()
			var col_shape = CollisionShape3D.new()
			col_shape.shape = shape
			body.add_child(col_shape)
			body.global_transform = child.global_transform
			root.call_deferred("add_child", body)

	print("Генерация завершена")
