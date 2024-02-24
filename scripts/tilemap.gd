extends TileMap

var tile_layer = 0
var tile_set_id = 0

var state_atlas_corrds: Dictionary = {
	1: Vector2(0, 0),
	2: Vector2(1, 0),
	3: Vector2(2, 0),
}

func make_tilemap(w: Wave) -> void:
	for cy: Array in w.grid:
		for cx: Cell in cy:
			var x_i = cy.find(cx)
			var y_i = w.grid.find(cy)

			if cx.states.size() == 1:
				var atlas_coords = state_atlas_corrds[cx.states[0]]
				set_cell(tile_layer, Vector2(x_i, y_i), tile_set_id, atlas_coords)
			# else:
			# 	tilemap.set_cell(0, Vector2(x_i, y_i), 0, Vector2(0, 0))
