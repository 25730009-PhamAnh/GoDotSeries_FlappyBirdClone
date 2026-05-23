## Tuning resource. Every numeric knob a designer/playtester might want to twist
## lives here. See design/gdd/flappy-bird.md for the "what does this do" notes.
class_name Tuning
extends Resource

@export_group("Bird")
@export var gravity: float = 1200.0
@export var flap_velocity: float = -380.0
@export var max_fall_speed: float = 600.0
@export var bird_rotation_max_deg: float = 30.0

@export_group("Pipes")
@export var pipe_scroll_speed: float = 150.0
@export var pipe_gap: float = 115.0
@export var pipe_spawn_interval: float = 1.4
@export var pipe_gap_y_min: float = 120.0
@export var pipe_gap_y_max: float = 320.0  ## viewport - ground (112) - half_gap (57.5) - margin

@export_group("World")
@export var viewport_size: Vector2i = Vector2i(288, 512)
@export var ground_height: float = 112.0  ## matches base.png
