## Game container. Owns Bird, PipeSpawner, Ground, HUD, and the ScoreStore.
## State machine: WAITING (first flap starts) → PLAYING → GAME_OVER → restart.
class_name Main
extends Node2D

const BACKGROUND_PARALLAX_RATIO: float = 0.2  ## sky scrolls at 1/5 of pipe speed

enum State { WAITING, PLAYING, GAME_OVER }

@export var tuning: Tuning

@onready var _bird: Bird = $Bird
@onready var _pipe_spawner: PipeSpawner = $PipeSpawner
@onready var _hud: Hud = $Hud
@onready var _ground_scroll: Parallax2D = $GroundScroll
@onready var _background_scroll: Parallax2D = $BackgroundScroll
@onready var _flap_sound: AudioStreamPlayer = $FlapSound
@onready var _hit_sound: AudioStreamPlayer = $HitSound
@onready var _die_sound: AudioStreamPlayer = $DieSound
@onready var _point_sound: AudioStreamPlayer = $PointSound

var _state: State = State.WAITING
var _score_store: ScoreStore
var _bird_start_position: Vector2

func _ready() -> void:
	assert(tuning != null, "Main requires a Tuning resource")
	_score_store = ScoreStore.new()
	_bird_start_position = _bird.position

	_bird.crashed.connect(_on_bird_crashed)
	_bird.flapped.connect(_on_bird_flapped)
	_pipe_spawner.scored.connect(_on_scored)
	_hud.restart_pressed.connect(_restart)

	_set_world_scrolling(true)

	_hud.set_score(0)
	_hud.show_start_prompt()

func _unhandled_input(event: InputEvent) -> void:
	if _state == State.WAITING and event.is_action_pressed("flap"):
		_begin_play()

func _begin_play() -> void:
	_state = State.PLAYING
	_hud.hide_start_prompt()
	_pipe_spawner.start()

func _on_bird_flapped() -> void:
	_flap_sound.play()

func _on_scored() -> void:
	if _state != State.PLAYING:
		return
	_score_store.add_point()
	_hud.set_score(_score_store.current)
	_point_sound.play()

func _on_bird_crashed() -> void:
	if _state == State.GAME_OVER:
		return
	_state = State.GAME_OVER
	_pipe_spawner.stop()
	_set_world_scrolling(false)
	_score_store.commit_best()
	_hit_sound.play()
	await get_tree().create_timer(0.4).timeout
	_die_sound.play()
	_hud.show_game_over(_score_store.current, _score_store.best)

func _restart() -> void:
	_pipe_spawner.clear_all()
	_score_store.reset_current()
	_bird.reset(_bird_start_position)
	_hud.set_score(0)
	_hud.hide_game_over()
	_hud.show_start_prompt()
	_set_world_scrolling(true)
	_state = State.WAITING

func _set_world_scrolling(active: bool) -> void:
	var speed: float = tuning.pipe_scroll_speed if active else 0.0
	_ground_scroll.autoscroll = Vector2(-speed, 0)
	_background_scroll.autoscroll = Vector2(-speed * BACKGROUND_PARALLAX_RATIO, 0)
