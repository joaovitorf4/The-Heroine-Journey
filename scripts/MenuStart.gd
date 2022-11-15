extends Control


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene("res://cenas/CrimsonPlains.tscn")


func _on_Controls_pressed():
	get_tree().change_scene("res://cenas/Controles.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://cenas/Creditos.tscn")
