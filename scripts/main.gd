extends Node2D

var compat: Dictionary = {
	1: [2],
	2: [3],
	3: [2],
}

var state_atlas_corrds: Dictionary = {
	1: Vector2(0, 0),
	2: Vector2(1, 0),
	3: Vector2(2, 0),
}

var states = compat.keys()

var com: Compat = Compat.new()
var m = com.build_compat_matrix(states, compat)
@onready var tilemap: TileMap = $TileMap

var w: Wave = Wave.new(95, 95, states, m, tilemap)

func _ready() -> void:
	while !(w.is_contradictory() || w.is_collapsed()):
		w.iterate()
		await get_tree().create_timer(0.06).timeout
		make_tilemap()
		# print("\n")
		# print_wave()

func print_wave() -> void:
	for row in w.grid:
		var r = []
		for c in row:
			r.append(c.states)
		print(r)

func make_tilemap():
	for cy: Array in w.grid:
		for cx: Cell in cy:
			var x_i = cy.find(cx)
			var y_i = w.grid.find(cy)

			if cx.states.size() == 1:
				var atlas_coords = state_atlas_corrds[cx.states[0]]
				tilemap.set_cell(0, Vector2(x_i, y_i), 0, atlas_coords)
			# else:
			# 	tilemap.set_cell(0, Vector2(x_i, y_i), 0, Vector2(0, 0))
