extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_back_pressed():
	get_tree().change_scene("res://cenas/MenuStart.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://cenas/risada do peludao.tscn")
	yield(get_tree().create_timer(31), "timeout")
	

