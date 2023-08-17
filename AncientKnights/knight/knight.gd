extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node("Animation")
@onready var texture: Sprite2D = get_node("Texture")
@onready var attack_area_collision: CollisionShape2D = get_node("AttackArea/Collision")
@export var move_speed: float = 256.0
@export var health: int = 10
@export var damage: int = 1

var can_attack: bool = true

func _physics_process(delta: float) -> void:
	if can_attack == false:
		return
	
	move()
	animate()
	attack_handler()
	
func move() -> void:
	var direction: Vector2 = get_direction()
	print(direction.length())
	velocity = direction * move_speed
	move_and_slide()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_up", "move_down")
	).normalized()

func animate() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		attack_area_collision.position.x = 28 #58
		
	if velocity.x < 0:
		texture.flip_h = true
		attack_area_collision.position.x = -28 #-58
	
	if velocity != Vector2.ZERO:
		animation.play("run")
		return
		
	animation.play("idle")

func attack_handler() -> void:
	if Input.is_action_just_pressed("attack") and can_attack:
		can_attack = false
		animation.play("attack")

func _on_animation_finished(_anim_name: String) -> void:
	can_attack = true

func on_attack_area_body_entered(body) -> void:
	body.update_health(damage)

func update_health(value: int) -> void:
	health -= value
	if health <= 0:
		print("Morreu")
