extends AudioStreamPlayer2D

export(Array, AudioStream) var DEFAULT_FOOTSTEPS: Array;
export(float) var step_walk_delay: float = 0.5;
export(float) var step_run_delay: float = 0.25;
var _step_delay: float = step_walk_delay;
var _time_left: float = _step_delay;
onready var movement: PlayerMovement = get_node("../../Functions/Movement") as PlayerMovement;
var rng: RandomNumberGenerator = RandomNumberGenerator.new();

func _ready():
	rng.randomize();

func _process(delta) -> void:
	_process_footsteps(delta);

func _process_footsteps(delta) -> void:
	
	if not movement.is_moving:
		return;
	
	
	if movement.is_running:
		_step_delay = step_run_delay;
	else:
		_step_delay = step_walk_delay;
	
	_time_left -= delta;
	
	if _time_left <= 0:
		_time_left = _step_delay;
		play_footstep();

func play_footstep():
	var _index = rng.randi_range(0,DEFAULT_FOOTSTEPS.size() - 1);
	var audio_clip = DEFAULT_FOOTSTEPS[_index];
	self.stream = audio_clip;
	self.play();
