extends Node2D

var compat: Dictionary = {
	1: [2],
	2: [1],
	3: [2]
}

var states = compat.keys()

var com: Compat = Compat.new()
var m = com.build_compat_matrix(states, compat)

var w: Wave = Wave.new(8, 8, states, m)

func _ready() -> void:
	while !(w.is_contradictory() || w.is_collapsed()):
		w.iterate()
		await get_tree().create_timer(0.2).timeout
		print("\n")
		printWave(w)

#	[[3], [2], [1], [2], [2], [1], [2], [2]]
#	[[2], [2], [1], [1], [1], [1], [2], [2]]
#	[[2], [2], [1], [1], [2], [2], [3], [3]]
#	[[1], [1], [1], [2], [3], [2], [3], [3]]
#	[[1], [2], [3], [2], [2], [3], [3], [3]]
#	[[1], [1], [2], [1], [1], [2], [2], [3]]
#	[[2], [1], [1], [1], [1], [2], [2], [3]]

func printWave(w: Wave) -> void:
	for row in w.grid:
		var r = []
		for c in row:
			r.append(c.states)
		print(r)
	
	
		

	

