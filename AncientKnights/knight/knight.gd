extends CharacterBody2D

@export var move_speed: float = 256.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = get_direction()
	print(direction.length())
	velocity = direction * move_speed
	move_and_slide()


func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_up", "move_down")
	).normalized()
