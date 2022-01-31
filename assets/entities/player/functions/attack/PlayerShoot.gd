extends Node
class_name PlayerShoot

onready var aim: PlayerAim = get_node("../PlayerAim") as PlayerAim;
onready var current_weapon: WeaponProperties;
onready var weapons: Array = get_node("../Weapons").get_children();

export(int) var weapon_index: int = 0;
var can_shoot: bool = true;
var pump_timer: Timer = Timer.new();

signal on_shoot();
signal on_weapon_swap();

func _ready():
	self.add_child(pump_timer);
	pump_timer.connect("timeout",self,"_on_pump_finish");
	current_weapon = weapons[weapon_index];

func _input(event):
	
	_process_weapon_swap(event);
	
	if event.is_action_pressed("shoot"):
		if aim.is_aiming and can_shoot:
			fire_weapon();
			_process_pump_delay();
			emit_signal("on_shoot");


func _process_weapon_swap(event: InputEvent):
	
	var old_index = weapon_index;
	
	if event.is_action_pressed("weapon 1"):
		weapon_index = 0;
	if event.is_action_pressed("weapon 2"):
		weapon_index = 1;
	if event.is_action_pressed("weapon 3"):
		weapon_index = 2;
		
	if old_index == weapon_index:
		return;
		
	current_weapon = weapons[clamp(weapon_index,0,weapons.size()-1)];
	emit_signal("on_weapon_swap");
	_process_pump_delay();


func fire_weapon():
	var bullet_root: Node2D = current_weapon.bullet_scene.instance() as Node2D;
	get_tree().get_root().add_child(bullet_root);
	bullet_root.global_transform.origin = aim.get_node("aim_position").global_transform.origin;
	bullet_root.rotation = aim.get_node("aim_position").rotation;
	
	for bullet in bullet_root.get_children():
		bullet.linear_velocity = (bullet.global_transform.x * current_weapon.bullet_speed);
	
func _process_pump_delay():
	if current_weapon.is_pump_action:
		pump_timer.start(current_weapon.pump_delay);
		can_shoot = false;
		

func _on_pump_finish():
	can_shoot = true;
	pump_timer.stop();
