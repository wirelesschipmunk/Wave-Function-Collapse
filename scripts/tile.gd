class_name Tile

var ax
var ay
var edge_compat
var tile_rotation

func _init(ax: int, ay: int, tile_rotation: int, edge_compat: Dictionary) -> void:
	self.ax = ax
	self.ay = ay
	self.edge_compat = edge_compat
	self.tile_rotation = tile_rotation


static func make_rotations(ax: int, ay: int, edge_compat: Dictionary) -> Array:
	var r_0 = Tile.new(ax, ay, 0, edge_compat)
	var r_90 = Tile.new(ax, ay, 1, rotate(r_0.edge_compat))
	var r_180 = Tile.new(ax, ay, 2, rotate(r_90.edge_compat))
	var r_270 = Tile.new(ax, ay, 3, rotate(r_180.edge_compat))
	return [r_0, r_90, r_180, r_270]

static func rotate(edge_compat: Dictionary):
	return {"left": edge_compat["down"], "right": edge_compat["up"], "up": edge_compat["left"], "down": edge_compat["right"]}

static func make_edge_compat_all(e: Array) -> Dictionary:
	return {"left": e, "right": e, "up": e, "down": e}
static func make_edge_compat_x_y(x: Array, y: Array):
	return {"left": x, "right": x, "up": y, "down": y}
static func make_edge_compat(l: Array, r: Array, u: Array, d: Array):
	return {"left": l, "right": r, "up": u, "down": d}
