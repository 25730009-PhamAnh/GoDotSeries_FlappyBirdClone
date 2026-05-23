## Game container. Owns Bird, PipeSpawner, Ground, HUD, and the ScoreStore.
## State machine: WAITING (first flap starts) → PLAYING → GAME_OVER → restart.
class_name Main
extends Node2D

enum State { WAITING, PLAYING, GAME_OVER }

@export var tuning: Tuning

@onready var _bird: Bird = $Bird
@onready var _pipe_spawner: PipeSpawner = $PipeSpawner
@onready var _hud: Hud = $Hud

var _state: State = State.WAITING
var _score_store: ScoreStore
var _bird_start_position: Vector2

func _ready() -> void:
	assert(tuning != null, "Main requires a Tuning resource")
	_score_store = ScoreStore.new()
	_bird_start_position = _bird.position

	_bird.crashed.connect(_on_bird_crashed)
	_pipe_spawner.scored.connect(_on_scored)
	_hud.restart_pressed.connect(_restart)

	_hud.set_score(0)

func _unhandled_input(event: InputEvent) -> void:
	if _state == State.WAITING and event.is_action_pressed("flap"):
		_begin_play()

func _begin_play() -> void:
	_state = State.PLAYING
	_pipe_spawner.start()

func _on_scored() -> void:
	if _state != State.PLAYING:
		return
	_score_store.add_point()
	_hud.set_score(_score_store.current)

func _on_bird_crashed() -> void:
	if _state == State.GAME_OVER:
		return
	_state = State.GAME_OVER
	_pipe_spawner.stop()
	_score_store.commit_best()
	_hud.show_game_over(_score_store.current, _score_store.best)

func _restart() -> void:
	_pipe_spawner.clear_all()
	_score_store.reset_current()
	_bird.reset(_bird_start_position)
	_hud.set_score(0)
	_hud.hide_game_over()
	_state = State.WAITING
