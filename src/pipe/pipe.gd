## A pipe pair: top + bottom StaticBody2D with pipe-green sprites + an Area2D
## between them the bird passes through to score. Scrolls left at a constant speed.
##
## Geometry: the top and bottom bodies are baked at local y=0 representing the
## edge of the gap (sprite cap aligns with body origin). `configure()` just moves
## the bodies to the right gap edges and sizes the score trigger.
class_name Pipe
extends Node2D

signal scored

## Width of each pipe column (matches pipe-green.png).
const PIPE_WIDTH: float = 52.0

@export var scroll_speed: float = 150.0

var _scored: bool = false

@onready var _top_body: StaticBody2D = $TopBody
@onready var _bottom_body: StaticBody2D = $BottomBody
@onready var _score_area: Area2D = $ScoreArea
@onready var _score_collider: CollisionShape2D = $ScoreArea/ScoreShape

func _ready() -> void:
	_score_area.body_entered.connect(_on_score_body_entered)

func _physics_process(delta: float) -> void:
	position.x -= scroll_speed * delta

## Place the gap centered on `gap_center_y` with vertical opening `gap_height`.
func configure(gap_center_y: float, gap_height: float) -> void:
	var half_gap: float = gap_height * 0.5
	_top_body.position.y = gap_center_y - half_gap
	_bottom_body.position.y = gap_center_y + half_gap

	var score_rect: RectangleShape2D = RectangleShape2D.new()
	score_rect.size = Vector2(4.0, gap_height)
	_score_collider.shape = score_rect
	_score_collider.position = Vector2(PIPE_WIDTH * 0.5, gap_center_y)

func _on_score_body_entered(body: Node2D) -> void:
	if _scored:
		return
	if body is Bird:
		_scored = true
		scored.emit()
