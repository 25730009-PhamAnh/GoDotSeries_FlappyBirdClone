## The bird. Falls under gravity, flaps upward on the `flap` input action.
## Emits `crashed` when it hits a body on its collision layer.
class_name Bird
extends CharacterBody2D

signal crashed

@export var tuning: Tuning

var _alive: bool = true

func _ready() -> void:
	assert(tuning != null, "Bird requires a Tuning resource")

func _physics_process(delta: float) -> void:
	if not _alive:
		return

	if Input.is_action_just_pressed("flap"):
		velocity.y = tuning.flap_velocity

	velocity.y = minf(velocity.y + tuning.gravity * delta, tuning.max_fall_speed)
	_update_rotation()

	var collided: bool = move_and_slide()
	if collided:
		_die()

## Visual tilt: lerp from -max (full up on flap) to +max (full down at terminal).
func _update_rotation() -> void:
	var t: float = clampf(velocity.y / tuning.max_fall_speed, -1.0, 1.0)
	var max_rad: float = deg_to_rad(tuning.bird_rotation_max_deg)
	rotation = lerpf(-max_rad, max_rad, (t + 1.0) * 0.5)

func _die() -> void:
	if not _alive:
		return
	_alive = false
	crashed.emit()

## Called by Main on restart.
func reset(start_position: Vector2) -> void:
	position = start_position
	velocity = Vector2.ZERO
	rotation = 0.0
	_alive = true
