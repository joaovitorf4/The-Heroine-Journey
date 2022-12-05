extends KinematicBody2D

var flip = true
var posicao_inicial
var posicao_final
var velocidade = 0.9
export var health = 1
var hitted = false

func _ready():
	$AnimatedSprite.play("Walk")
	posicao_inicial = $".".position.x
	posicao_final = posicao_inicial + 500
	
	
func _process(delta):
#	print($".".position.x)
	if(posicao_inicial <= posicao_final and flip):
		$".".position.x -= velocidade
		$AnimatedSprite.flip_h = false
		if($".".position.x >= posicao_final):
			flip = false

	if($".".position.x >= posicao_inicial and !flip):
		$".".position.x += velocidade
		$AnimatedSprite.flip_h = true
		if($".".position.x <= posicao_inicial):
			flip = true

func _on_AnimatedSprite_animation_finished():
	pass # Replace with function body.


func _on_hitbox_body_entered(body):
	hitted = true
	body.velocity.y -= 250
	health -= 1
	if health < 1:
		$AnimatedSprite.play("Death")
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
		get_node("ray_wall/hitbox/collision").set_deferred("disable", true)
