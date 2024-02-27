class_name Compat

var directions = [
	"left",
	"right",
	"up",
	"down"
]

var opps = {
	"left": "right",
	"right": "left",
	"up": "down",
	"down": "up"
}

func build_compat_matrix(tiles: Array) -> Array:
	var m = []
	# loops over all possible s1 states
	for t1 in tiles:
		var row = []
		# loops over all possible s2 states
		for t2 in tiles:
			var dc = {}
			for d in directions:
				var t1_edge_compat = t1.edge_compat[d]
				var t2_edge_compat = t2.edge_compat[opps[d]]
				var	compat = false

				for t2_edge in t2_edge_compat:
					if t1_edge_compat.has(t2_edge):
						compat = true
						break

				dc[d] = compat
			row.append(dc)
		m.append(row)
	
	return m
