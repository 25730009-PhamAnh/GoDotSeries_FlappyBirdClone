## Score display + game-over panel. Emits `restart_pressed` when the player
## wants another go.
class_name Hud
extends CanvasLayer

signal restart_pressed

@onready var _score_label: Label = $ScoreLabel
@onready var _game_over_panel: Control = $GameOverPanel
@onready var _final_score_label: Label = $GameOverPanel/VBox/FinalScore
@onready var _best_score_label: Label = $GameOverPanel/VBox/BestScore
@onready var _restart_button: Button = $GameOverPanel/VBox/RestartButton

func _ready() -> void:
	_game_over_panel.visible = false
	_restart_button.pressed.connect(func() -> void: restart_pressed.emit())

func set_score(value: int) -> void:
	_score_label.text = str(value)

func show_game_over(final_score: int, best_score: int) -> void:
	_score_label.visible = false
	_final_score_label.text = "Score: %d" % final_score
	_best_score_label.text = "Best:  %d" % best_score
	_game_over_panel.visible = true

func hide_game_over() -> void:
	_score_label.visible = true
	_game_over_panel.visible = false
