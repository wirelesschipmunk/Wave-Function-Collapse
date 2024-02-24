extends Node2D

const DIM = 20

@onready var tilemap: TileMap = $TileMap

var compat: Dictionary = {
	1: [2],
	2: [3, 1],
	3: [2],
}

var states = compat.keys()

var com: Compat = Compat.new()
var m = com.build_compat_matrix(states, compat)

var w: Wave = Wave.new(DIM, DIM, states, m, tilemap)

func _ready() -> void:
	#var tileset = load("res://tilemap.png").get_image()
	#var tile_coords = Vector2(1, 1)
	
	var i = 0
	while !(w.is_contradictory() || w.is_collapsed()):
		w.iterate()
		i += 1
		print(cells_collapsed())
	tilemap.make_tilemap(w)
		 #print("\n")
		 #print_wave()

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
