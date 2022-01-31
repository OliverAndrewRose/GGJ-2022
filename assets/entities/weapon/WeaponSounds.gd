extends AudioStreamPlayer2D

export(Array,AudioStream) var shoot_sounds: Array;
export(Array,AudioStream) var pump_sounds: Array;
var rng: RandomNumberGenerator = RandomNumberGenerator.new();

onready var weapon: WeaponProperties = get_node("..") as WeaponProperties;
onready var shoot: PlayerShoot = get_node("../../../PlayerShoot") as PlayerShoot;
onready var pump_player: AudioStreamPlayer2D = $PumpSound

var pump_sound_timer: Timer = Timer.new();
export(float) var pump_sound_delay: float = 0.25;

func _ready():
	self.add_child(pump_sound_timer);
	pump_sound_timer.connect("timeout",self,"play_pump_sound");
	shoot.connect("on_shoot", self,"play_weapon_sound");
	shoot.connect("on_weapon_swap", self,"play_pump_sound");
	
	rng.randomize();
	

func play_weapon_sound():
	if not weapon.is_current_weapon():
		return;
	
	var _index = rng.randi_range(0,shoot_sounds.size() - 1);
	self.stream = shoot_sounds[_index];
	self.play();
	
	if weapon.is_pump_action:
		pump_sound_timer.start(pump_sound_delay);


func play_pump_sound():
	if not weapon.is_pump_action or not weapon.is_current_weapon():
		return;
		
	var _index = rng.randi_range(0,pump_sounds.size() - 1);
	pump_player.stream = pump_sounds[_index];
	pump_player.play();
	pump_sound_timer.stop();
