extends TileMap

var tileset: Image = load("res://tilemap_compat.png").get_image()

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

func get_tile_edge_pixels(atlas_tx: int, atlas_ty: int, ts: int) -> Dictionary:
	var t_origin = Vector2(atlas_tx * (ts + 1), atlas_ty * (ts + 1))
	var ps: Dictionary = {"left": [], "right": [], "up": [], "down": []}
	
	# up down
	for y in ts:
		for x in ts:
			var p = tileset.get_pixel(t_origin.x + x, t_origin.y + y).to_html()
			if x == 0:
				ps["left"].append(p)
			if x == ts - 1:
				ps["right"].append(p)
			if y == 0:
				ps["up"].append(p)
			if y == ts - 1:
				ps["down"].append(p)
	return ps



