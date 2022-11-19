extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 800
var gravity = 1200
var jump_force = -800
var is_grounded
onready var raycasts = $raycasts
var health = 5
var hurted = false
var knock_back_dir = 1
var knock_back_int = 2000

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	_get_input()
	
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_ground()
	
	_set_animation()

func _set_animation():
	if !is_grounded:
		$texture.play("Jump")
	if velocity.y > 0 and !is_grounded:
		$texture.play("Fall")
	elif velocity.x != 0:
		$texture.play("Run")
	if velocity.x == 0:
		$texture.play("Idle")
	if hurted == true:
		$texture.play("Hurt")
	if health < 1:
		$texture.play("Death")
		
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$texture.scale.x = move_direction
		knock_back_dir = move_direction
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump") and is_grounded:
		velocity.y = jump_force / 2
		$JumpFx.play()
		
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false
	
func _knock_back():
	velocity.x = -knock_back_dir * knock_back_int
	velocity = move_and_slide(velocity)

func _on_hurtbox_body_entered(body):
	hurted = true
	if hurted == true:
		health -= 1
		$texture.play("Hurt")
		_knock_back()
		yield(get_tree().create_timer(0.2), "timeout")
		if health < 1:
			$texture.play("Death")
			queue_free()
			get_tree().reload_current_scene()
		
	get_node("hurtbox/collision").set_deferred("disable", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("hurtbox/collision").set_deferred("disable", false)
	hurted = false
	$texture.play("Idle")
	
		


func _on_texture_animation_finished():
	pass # Replace with function body.
