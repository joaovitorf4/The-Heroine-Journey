extends KinematicBody2D

var flip = true
var posicao_inicial
var posicao_final
var velocidade = 1.8
export var health = 3
var hitted = false

func _ready():
	$anim.play("run")
	posicao_inicial = $".".position.x
	posicao_final = posicao_inicial + 420
	
	
func _process(delta):
#	print($".".position.x)
	if(posicao_inicial <= posicao_final and flip):
		$".".position.x += velocidade
		$Sprite.flip_h = false
		if($".".position.x >= posicao_final):
			flip = false

	if($".".position.x >= posicao_inicial and !flip):
		$".".position.x -= velocidade
		$Sprite.flip_h = true
		if($".".position.x <= posicao_inicial):
			flip = true

func _on_hitbox_body_entered(body):
	hitted = true
	if hitted == true:
		$anim.play("hit")
		yield(get_tree().create_timer(0.4), "timeout")
		$anim.play("run")
	body.velocity.y -= 250
	health -= 1
	if health < 1:
		velocidade = 0
		$anim.play("death")
		yield(get_tree().create_timer(2), "timeout")
		queue_free()
		get_node("ray_wall/hitbox/collision").set_deferred("disable", true)
		get_tree().change_scene("res://cenas/Creditos.tscn")

			
func _on_AnimatedSprite_animation_finished():
	pass # Replace with function body.
