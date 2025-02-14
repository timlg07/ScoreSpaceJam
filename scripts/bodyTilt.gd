extends Spatial

var angle := 15
var time := 0.5
var duration := 0.5

func _physics_process(delta) -> void:
	if($body != null):
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			time = 0.0
		if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
			time = 0.0
		if time < duration:
			time += delta
			var dir := Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
			var temp_interpol = lerp($body.get_rotation_degrees().y, angle * dir, time/duration)
			$body.set_rotation_degrees(Vector3(0, temp_interpol, 0))
