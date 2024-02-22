extends Sprite2D

var speed = 300

func _process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		position.x += direction * speed * delta
