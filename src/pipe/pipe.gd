## A pipe pair: top StaticBody2D + bottom StaticBody2D + an Area2D between them
## that the bird passes through to score. Scrolls left at a constant speed.
##
## The pair geometry is built procedurally so we don't need separate scenes per
## gap position — call `configure()` after spawning.
class_name Pipe
extends Node2D

signal scored

## Width of each pipe column (visual + collision).
const PIPE_WIDTH: float = 52.0
## Total height each pipe column extends — large enough to cover the viewport.
const PIPE_TALL: float = 600.0

@export var scroll_speed: float = 150.0

var _scored: bool = false

@onready var _top_collider: CollisionShape2D = $TopBody/TopShape
@onready var _bottom_collider: CollisionShape2D = $BottomBody/BottomShape
@onready var _top_visual: ColorRect = $TopBody/TopVisual
@onready var _bottom_visual: ColorRect = $BottomBody/BottomVisual
@onready var _score_area: Area2D = $ScoreArea
@onready var _score_collider: CollisionShape2D = $ScoreArea/ScoreShape

func _ready() -> void:
	_score_area.body_entered.connect(_on_score_body_entered)

func _physics_process(delta: float) -> void:
	position.x -= scroll_speed * delta

## Place the gap centered on `gap_center_y` with vertical opening `gap_height`.
func configure(gap_center_y: float, gap_height: float) -> void:
	var half_gap: float = gap_height * 0.5
	var top_bottom_edge: float = gap_center_y - half_gap
	var bottom_top_edge: float = gap_center_y + half_gap

	var top_rect: RectangleShape2D = RectangleShape2D.new()
	top_rect.size = Vector2(PIPE_WIDTH, PIPE_TALL)
	_top_collider.shape = top_rect
	_top_collider.position = Vector2(0, top_bottom_edge - PIPE_TALL * 0.5)
	_top_visual.position = Vector2(-PIPE_WIDTH * 0.5, top_bottom_edge - PIPE_TALL)
	_top_visual.size = Vector2(PIPE_WIDTH, PIPE_TALL)

	var bottom_rect: RectangleShape2D = RectangleShape2D.new()
	bottom_rect.size = Vector2(PIPE_WIDTH, PIPE_TALL)
	_bottom_collider.shape = bottom_rect
	_bottom_collider.position = Vector2(0, bottom_top_edge + PIPE_TALL * 0.5)
	_bottom_visual.position = Vector2(-PIPE_WIDTH * 0.5, bottom_top_edge)
	_bottom_visual.size = Vector2(PIPE_WIDTH, PIPE_TALL)

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
