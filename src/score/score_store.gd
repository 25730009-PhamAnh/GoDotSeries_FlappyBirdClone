## Persists best score to `user://best_score.cfg`. Pure logic — no nodes, no I/O
## in tests (override `_save_path` to use a temp file).
class_name ScoreStore
extends RefCounted

const DEFAULT_PATH: String = "user://best_score.cfg"

var current: int = 0
var best: int = 0

var _save_path: String

func _init(save_path: String = DEFAULT_PATH) -> void:
	_save_path = save_path
	_load_best()

func reset_current() -> void:
	current = 0

func add_point() -> void:
	current += 1
	if current > best:
		best = current

## Returns true if the new value was persisted.
func commit_best() -> bool:
	var f: FileAccess = FileAccess.open(_save_path, FileAccess.WRITE)
	if f == null:
		return false
	return f.store_line(str(best))

func _load_best() -> void:
	if not FileAccess.file_exists(_save_path):
		return
	var f: FileAccess = FileAccess.open(_save_path, FileAccess.READ)
	if f == null:
		return
	var line: String = f.get_line().strip_edges()
	if line.is_valid_int():
		best = int(line)
