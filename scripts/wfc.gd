extends Node2D

const DIM = 20

const AIR = 1
const EDGE = 2
const DOUBLE_EDGE = 3
const INNER_WALL = 5
const SINGLE_EDGE_1 = 6
const SINGLE_EDGE_2 = 7
const SINGLE_EDGE_3 = 8
const SINGLE_EDGE_4 = 9
const CORNER = 10

signal generate
var generating = false

# var tiles: Dictionary = {
# 	# straight double edge
# 	1: Tile.new([1, 2, 3, 4], 0, 0, Tile.make_edge_compat_x_y([AIR], [DOUBLE_EDGE])),
# 	# end of straight double edge
# 	2: Tile.new([5, 6, 7, 8], 1, 0, Tile.make_edge_compat([AIR], [AIR], [AIR], [DOUBLE_EDGE])),
# 	# completely wall
# 	3: Tile.new([9], 0, 1, Tile.make_edge_compat_all([INNER_WALL])),
# 	# inner corner
# 	4: Tile.new([10, 11, 12, 13], 1, 1, Tile.make_edge_compat([INNER_WALL], [SINGLE_EDGE_1], [INNER_WALL], [SINGLE_EDGE_1])),
# 	# edge
# 	5: Tile.new([14, 15, 16, 17], 0, 2, Tile.make_edge_compat([SINGLE_EDGE_1], [SINGLE_EDGE_1], [INNER_WALL], [AIR])),
# 	# corner
# 	6: Tile.new([18, 19, 20, 21], 1, 2, Tile.make_edge_compat([SINGLE_EDGE_1], [AIR], [SINGLE_EDGE_1], [AIR])),
# 	# air with SHADOW
# 	7: Tile.new([22], 0, 3, Tile.make_edge_compat([AIR], [AIR], [EDGE, CORNER], [AIR])),
# 	# air
# 	8: Tile.new([23], 1, 3, Tile.make_edge_compat_all([AIR, EDGE, CORNER])),
# 	# double inner corner
# 	9: Tile.new([24, 25, 27, 28], 0, 4, Tile.make_edge_compat([SINGLE_EDGE_1], [SINGLE_EDGE_1], [DOUBLE_EDGE], [INNER_WALL]))
# }

# var rotations = [
	# inner corner
	# Tile.make_rotations([2], 1, 1, Tile.make_edge_compat([INNER_WALL], [SINGLE_EDGE_1], [INNER_WALL], [SINGLE_EDGE_1])),
	# edge
	# Tile.make_rotations(0, 2, Tile.make_edge_compat([SINGLE_EDGE_1], [SINGLE_EDGE_1], [INNER_WALL], [AIR])),
	# corner
	# Tile.make_rotations([4], 1, 2, Tile.make_edge_compat([SINGLE_EDGE_1], [AIR], [SINGLE_EDGE_1], [AIR]))
# ]

var tiles = [
	# inner wall
	Tile.new(0, 1, 0, Tile.make_edge_compat_all([INNER_WALL])),
	# air
	Tile.new(1, 3, 0, Tile.make_edge_compat_all([AIR])),
	# edges
	Tile.new(0, 2, 0, Tile.make_edge_compat([SINGLE_EDGE_1], [SINGLE_EDGE_1], [INNER_WALL], [AIR])),
	Tile.new(0, 2, 1, Tile.make_edge_compat([AIR], [INNER_WALL], [SINGLE_EDGE_2], [SINGLE_EDGE_2])),
	Tile.new(0, 2, 2, Tile.make_edge_compat([SINGLE_EDGE_3], [SINGLE_EDGE_3], [AIR], [INNER_WALL])),
	Tile.new(0, 2, 3, Tile.make_edge_compat([INNER_WALL], [AIR], [SINGLE_EDGE_4], [SINGLE_EDGE_4])),
	# corners
	Tile.new(1, 2, 0, Tile.make_edge_compat([SINGLE_EDGE_1], [AIR], [SINGLE_EDGE_4], [AIR])),
	Tile.new(1, 2, 1, Tile.make_edge_compat([AIR], [SINGLE_EDGE_1], [SINGLE_EDGE_2], [AIR])),
	Tile.new(1, 2, 2, Tile.make_edge_compat([AIR], [SINGLE_EDGE_3], [AIR], [SINGLE_EDGE_2])),
	Tile.new(1, 2, 3, Tile.make_edge_compat([SINGLE_EDGE_3], [AIR], [AIR], [SINGLE_EDGE_4])),
	# inner corners
	Tile.new(1, 1, 0, Tile.make_edge_compat([INNER_WALL], [SINGLE_EDGE_1], [INNER_WALL], [SINGLE_EDGE_4])),
	Tile.new(1, 1, 1, Tile.make_edge_compat([SINGLE_EDGE_1], [INNER_WALL], [INNER_WALL], [SINGLE_EDGE_2])),
	Tile.new(1, 1, 2, Tile.make_edge_compat([SINGLE_EDGE_3], [INNER_WALL], [SINGLE_EDGE_2], [INNER_WALL])),
	Tile.new(1, 1, 3, Tile.make_edge_compat([INNER_WALL], [SINGLE_EDGE_3], [SINGLE_EDGE_4], [INNER_WALL])),
]

var com: Compat = Compat.new()
var m: Array = com.build_compat_matrix(tiles)

var weights = [20, 200, 5,5,5,5, 2,2,2,2, 1,1,1,1]

var w: Wave = Wave.new(DIM, DIM, range(tiles.size()), weights, m)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && !generating:
		generate.emit()

func _on_generate() -> void:
	generating = true

	w = Wave.new(DIM, DIM, range(tiles.size()), weights, m)
	while !(w.is_contradictory() || w.is_collapsed()):
		w.iterate()
	$TileMap.make_tilemap(w, tiles)

	generating = false

func print_wave() -> void:
	for row in w.grid:
		var r = []
		for c in row:
			r.append(c.states)
		print(r)

func cells_collapsed():
	var count = 0
	for row in w.grid:
		for c: Cell in row:
			if c.is_collapsed():
				count += 1
	return count
