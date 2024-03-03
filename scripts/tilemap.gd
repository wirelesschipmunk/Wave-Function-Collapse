extends TileMap

#var tileset: Image = load("res://tilemap_compat.png").get_image()
# 90: transpose and flip x. 180: flip x and flip y. 270: transpose and flip y. 
# set_cell ( int x, int y, int tile, bool flip_x=false, bool flip_y=false, bool transpose=false ) 

var tile_layer = 0
var tile_set_id = 3

func make_tilemap(w: Wave, tiles: Array) -> void:
	for cy: Array in w.grid:
		for cx: Cell in cy:
			var x_i = cy.find(cx)
			var y_i = w.grid.find(cy)

			if cx.states.size() == 1:
				var state: int = cx.states[0]
				var tile: Tile = tiles[state]

				var atlas_coords = Vector2(tile.ax, tile.ay)
				# if state != 2:
				# 	await get_tree().create_timer(0.01).timeout
				set_cell(tile_layer, Vector2(x_i, y_i), tile_set_id, atlas_coords, tile.tile_rotation)
			# else:
			# 	tilemap.set_cell(0, Vector2(x_i, y_i), 0, Vector2(0, 0))

#func get_tile_edge_pixels(atlas_tx: int, atlas_ty: int, ts: int) -> Dictionary:
	#var t_origin = Vector2(atlas_tx * (ts + 1), atlas_ty * (ts + 1))
	#var ps: Dictionary = {"left": [], "right": [], "up": [], "down": []}
	#
	## up down
	#for y in ts:
		#for x in ts:
			#var p = tileset.get_pixel(t_origin.x + x, t_origin.y + y).to_html()
			#if x == 0:
				#ps["left"].append(p)
			#if x == ts - 1:
				#ps["right"].append(p)
			#if y == 0:
				#ps["up"].append(p)
			#if y == ts - 1:
				#ps["down"].append(p)
	#return ps



