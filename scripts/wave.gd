class_name Wave

var w: int
var h: int
var grid = []
var matrix
var tilemap: TileMap

func _init(W: int, H: int, s: Array, m: Array, t: TileMap):
	w = W
	h = H
	grid = init_grid(s)
	matrix = m
	tilemap = t


func init_grid(s) -> Array:
	var g = []
	for y in range(h):
		var col = []
		for x in range(w):
			col.append(Cell.new(x, y, s))
		g.append(col)
	
	return g

func iterate() -> void:
	var cs := get_min_entropy_cells()
	var c: Cell = cs.pick_random()

	c.observe()
	propagate(get_neighbors(c))

func propagate(queue: Array) -> void:
	while queue.size() > 0:
		var c: Cell = queue[0]
		queue.remove_at(0)

		var is_dirty = c.update(get_neighbors_with_directions(c), matrix)
		if (is_dirty):
			for n in get_neighbors(c):
				queue.append(n)

func get_neighbors(c: Cell) -> Array:
	var ns = []
	
	if c.x > 0:
		ns.append(grid[c.y][c.x - 1])
	if c.x < w - 1:
		ns.append(grid[c.y][c.x + 1])
	if c.y > 0:
		ns.append(grid[c.y - 1][c.x])
	if c.y < h - 1:
		ns.append(grid[c.y + 1][c.x])
			
	return ns

func get_neighbors_with_directions(c: Cell) -> Array:
	var ns = []
	
	if c.x > 0:
		ns.append({"cell": grid[c.y][c.x - 1], "dir": "left"})
	if c.x < w - 1:
		ns.append({"cell": grid[c.y][c.x + 1], "dir": "right"})
	if c.y > 0:
		ns.append({"cell": grid[c.y - 1][c.x], "dir": "up"})
	if c.y < h - 1:
		ns.append({"cell": grid[c.y + 1][c.x], "dir": "down"})
	
	return ns

func is_contradictory() -> bool:
	for y in range(grid.size()):
		for c: Cell in grid[y]:
			if c.is_contradictory():
				return true
	return false

func is_collapsed() -> bool:
	for y in range(grid.size()):
		for c: Cell in grid[y]:
			if !c.is_collapsed():
				return false
	return true

func get_min_entropy_cells() -> Array:
	var min_e
	for y in range(grid.size()):
		for c: Cell in grid[y]:
			if c.is_collapsed():
				continue
			var e = c.get_entropy()
			if !min_e:
				min_e = e
			if e < min_e:
				min_e = e
	
	var min_cs = []
	for y in range(grid.size()):
		for c: Cell in grid[y]:
			if c.get_entropy() == min_e:
				min_cs.append(c)
	return min_cs
