extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 800
var gravity = 1200
var jump_force = -800
var is_grounded
onready var raycasts = $raycasts

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	_get_input()
	
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_ground()
	
	_set_animation()
	
func _set_animation():
	if !is_grounded:
		$texture.play("Jump")
	elif velocity.x != 0:
		$texture.play("Run")
	else:
		$texture.play("Idle")
	
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$texture.scale.x = move_direction
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump") and is_grounded:
		velocity.y = jump_force / 2
		
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false
	
