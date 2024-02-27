class_name Cell

var states

var x
var y

func _init(X: int, Y: int, s: Array) -> void:
	states = s
	x = X
	y = Y

func update(ns, m) -> bool:
	if is_contradictory() || is_collapsed():
		return false
	
	var is_dirty = false
	for n in ns:
		var cell_states: Array = []
		for s1 in states: # loops over this cell's states
			var is_compatible = false
			for s2 in n["cell"].states: # loops over a neighbors states
				if is_compat(s1, s2, n["dir"], m):
					is_compatible = true
					break
			
			if is_compatible:
				cell_states.append(s1)
			else:
				is_dirty = true
			
		states = cell_states
	
	return is_dirty

func is_compat(s1, s2, d, m) -> bool:
	return m[s1][s2][d]

func observe(ws: Array) -> void:
	var pool = []

	for s in states:
		for i in range(ws[s]):
			pool.append(s)

	states = [pool.pick_random()]

func get_entropy() -> int:
	return states.size()

func is_contradictory() -> bool:
	return states.size() == 0

func is_collapsed() -> bool:
	return states.size() == 1
