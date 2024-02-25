class_name Tile

# "states: possible rotations"
var states
var ax
var ay
var edge_compat

func _init(states: Array, ax: int, ay: int, edge_compat: Dictionary) -> void:
	self.states = states
	self.ax = ax
	self.ay = ay
	self.edge_compat = edge_compat

static func make_edge_compat_all(e: Array) -> Dictionary:
	return {"left": e, "right": e, "up": e, "down": e}
static func make_edge_compat_x_y(x: Array, y: Array):
	return {"left": x, "right": x, "up": y, "down": y}
static func make_edge_compat(l: Array, r: Array, u: Array, d: Array):
	return {"left": l, "right": r, "up": u, "down": d}
