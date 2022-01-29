extends Node
class_name PlayerShoot

onready var aim: PlayerAim = get_node("../PlayerAim") as PlayerAim;
onready var weapon: WeaponProperties = get_node("../WeaponProperties") as WeaponProperties;

func _input(event):
	
	if event.is_action_pressed("shoot"):
		if aim.is_aiming:
			fire_weapon();
			pass
		pass

func fire_weapon():
	var bullet: RigidBody2D = weapon.bullet_scene.instance() as RigidBody2D;
	get_tree().get_root().add_child(bullet);
	bullet.global_transform.origin = aim.get_node("aim_position").global_transform.origin;
	bullet.rotation = aim.get_node("aim_position").rotation;
	bullet.add_central_force(bullet.global_transform.x * weapon.bullet_speed);
