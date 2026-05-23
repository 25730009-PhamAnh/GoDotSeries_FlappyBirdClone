## Spawns pipe pairs on an interval, owns their lifetime, and forwards score events.
## Stops spawning when `running` is false; clear_all() removes existing pipes on restart.
class_name PipeSpawner
extends Node2D

signal scored

const PIPE_SCENE: PackedScene = preload("res://src/pipe/pipe.tscn")

@export var tuning: Tuning
## Optional explicit RNG seed for deterministic playtests. 0 = randomize.
@export var rng_seed: int = 0

var running: bool = false

var _time_since_spawn: float = 0.0
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	assert(tuning != null, "PipeSpawner requires a Tuning resource")
	if rng_seed != 0:
		_rng.seed = rng_seed
	else:
		_rng.randomize()

func _process(delta: float) -> void:
	if not running:
		return
	_time_since_spawn += delta
	if _time_since_spawn >= tuning.pipe_spawn_interval:
		_time_since_spawn = 0.0
		_spawn_pipe()

func start() -> void:
	running = true
	_time_since_spawn = tuning.pipe_spawn_interval  ## spawn immediately

func stop() -> void:
	running = false
	for child: Node in get_children():
		if child is Pipe:
			(child as Pipe).scroll_speed = 0.0

func clear_all() -> void:
	for child: Node in get_children():
		if child is Pipe:
			child.queue_free()

func _spawn_pipe() -> void:
	var pipe: Pipe = PIPE_SCENE.instantiate()
	var gap_y: float = _rng.randf_range(tuning.pipe_gap_y_min, tuning.pipe_gap_y_max)
	pipe.scroll_speed = tuning.pipe_scroll_speed
	pipe.position = Vector2(tuning.viewport_size.x + Pipe.PIPE_WIDTH, 0)
	add_child(pipe)
	pipe.configure(gap_y, tuning.pipe_gap)
	pipe.scored.connect(_on_pipe_scored)

func _on_pipe_scored() -> void:
	scored.emit()
