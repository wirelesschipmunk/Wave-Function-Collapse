class_name Compat

var directions = [
	"left",
	"right",
	"up",
	"down"
]

func build_compat_matrix(states: Array, compat: Dictionary) -> Array:
	var m = []
	# loops over all possible s1 states
	for s1 in states:
		var row = []
		# loops over all possible s2 states
		for s2 in states:
			var dc = {}
			for d in directions:
				if compat[s1].has(s2) || compat[s2].has(s1):
					dc[d] = true
				elif s1 == s2: # if the states are the same they are compatible
					dc[d] = true
				else:
					dc[d] = false
			row.append(dc)
		# print(row)
		m.append(row)

	m[0][1]["up"] = false
	m[1][0]["down"] = false
	
	return m

		
