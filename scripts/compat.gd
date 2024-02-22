class_name Compat

func build_compat_matrix(states: Array, compat: Dictionary) -> Array:
	var m = []
	# loops over all possible s1 states
	for s1 in states:
		var row = []
		# loops over all possible s2 states
		for s2 in states:
			if compat[s1].has(s2) || compat[s2].has(s1):
				row.append(true)
			elif s1 == s2: # if the states are the same they are compatible
				row.append(true)
			else:
				row.append(false)
		# print(row)
		m.append(row)

	return m

# output

# [true, true, false]
# [true, true, true]
# [false, true, true]

		
