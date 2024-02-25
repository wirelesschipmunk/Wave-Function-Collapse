extends Node2D

const DIM = 50

const AIR = 0
const EDGE = 1
const DOUBLE_EDGE = 2
const INNER_WALL = 3
const SINGLE_EDGE = 4
const CORNER = 5

var states: Dictionary = {
	# straight double edge
	1: Tile.new([1, 2, 3, 4], 0, 0, Tile.make_edge_compat_x_y([AIR], [DOUBLE_EDGE])),
	# end of straight double edge
	2: Tile.new([5, 6, 7, 8], 1, 0, Tile.make_edge_compat([AIR], [AIR], [AIR], [DOUBLE_EDGE])),
	# completely wall
	3: Tile.new([9], 0, 1, Tile.make_edge_compat_all([INNER_WALL])),
	# inner corner
	4: Tile.new([10, 11, 12, 13], 1, 1, Tile.make_edge_compat([INNER_WALL], [SINGLE_EDGE], [INNER_WALL], [SINGLE_EDGE])),
	# edge
	5: Tile.new([14, 15, 16, 17], 0, 2, Tile.make_edge_compat([SINGLE_EDGE], [SINGLE_EDGE], [INNER_WALL], [AIR])),
	# corner
	6: Tile.new([18, 19, 20, 21], 1, 2, Tile.make_edge_compat([SINGLE_EDGE], [AIR], [SINGLE_EDGE], [AIR])),
	# air with SHADOW
	7: Tile.new([22], 0, 3, Tile.make_edge_compat([AIR], [AIR], [EDGE, CORNER], [AIR])),
	# air
	8: Tile.new([23], 1, 3, Tile.make_edge_compat_all([AIR, EDGE, CORNER])),
	# double inner corner
	9: Tile.new([24, 25, 27, 28], 0, 4, Tile.make_edge_compat([SINGLE_EDGE], [SINGLE_EDGE], [DOUBLE_EDGE], [INNER_WALL]))
}

var com: Compat = Compat.new()
var m = com.build_compat_matrix(states, compat)

var w: Wave = Wave.new(DIM, DIM, states, m, tilemap)

func _ready() -> void:
	var i = 0
	while !(w.is_contradictory() || w.is_collapsed()):
		w.iterate()
		i += 1
		print(cells_collapsed())
	$TileMap.make_tilemap(w)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

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
