extends Camera2D

var speed = 400

func _process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")

	position += direction * speed * delta

	if Input.is_action_just_pressed("zoom_in") && zoom != Vector2(0.1, 0.1):
		zoom += Vector2(0.3, 0.3)
	if Input.is_action_just_pressed("zoom_out") && zoom != Vector2(1.2, 1.2):
		zoom -= Vector2(0.3, 0.3)
