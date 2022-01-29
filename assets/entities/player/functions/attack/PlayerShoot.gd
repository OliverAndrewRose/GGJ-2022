extends Node
class_name PlayerShoot

onready var aim: PlayerAim = get_node("../PlayerShoot") as PlayerAim;
export(PackedScene) var bullet_scene: PackedScene;

func _input(event):
	
	if event.is_action_pressed("aim"):
		if aim.is_aiming:
			fire_weapon();
			pass
		pass

func fire_weapon():
	var bullet = bullet_scene.instance();
	
