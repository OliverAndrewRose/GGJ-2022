extends Node
class_name PlayerAim

var is_aiming: bool = false;

func _input(event):
	
	if event.is_action_pressed("aim"):
		toggle_aim();

func toggle_aim():
	if is_aiming:
		pass
	else:
		pass;


func aim_weapon():
	is_aiming = true;
	

func lower_weapon():
	is_aiming = false;
