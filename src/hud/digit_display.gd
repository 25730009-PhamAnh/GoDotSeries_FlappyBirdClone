## Renders an integer as a horizontal row of digit sprites (0-9.png). The
## sprites are different widths (notably "1" is 16px vs 24px for the rest), so
## children are sized to each texture's natural size via an HBoxContainer.
class_name DigitDisplay
extends HBoxContainer

const DIGIT_TEXTURES: Array[Texture2D] = [
	preload("res://Assets/Sprites/0.png"),
	preload("res://Assets/Sprites/1.png"),
	preload("res://Assets/Sprites/2.png"),
	preload("res://Assets/Sprites/3.png"),
	preload("res://Assets/Sprites/4.png"),
	preload("res://Assets/Sprites/5.png"),
	preload("res://Assets/Sprites/6.png"),
	preload("res://Assets/Sprites/7.png"),
	preload("res://Assets/Sprites/8.png"),
	preload("res://Assets/Sprites/9.png"),
]

@export var value: int = 0:
	set(v):
		value = maxi(0, v)
		if is_node_ready():
			_render()

func _ready() -> void:
	alignment = BoxContainer.ALIGNMENT_CENTER
	_render()

func _render() -> void:
	for child: Node in get_children():
		child.queue_free()
	for digit: String in str(value):
		var tex: TextureRect = TextureRect.new()
		tex.texture = DIGIT_TEXTURES[int(digit)]
		tex.stretch_mode = TextureRect.STRETCH_KEEP
		add_child(tex)
