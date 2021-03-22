extends Spatial

onready var helper_x := $helper_z/helper_x
onready var helper_z := $helper_z
onready var body := $helper_z/helper_x/bodyhelper

var speed := 0.4
var steer := 1.0
#var y_compensation := 1
#var z_compensation := 1
var speed_up_interval := 15.0
var time := 0.0
var speed_increase := 0.06

#func _physics_process(delta) -> void:
#	var y_weight
#	var z_weight
#	if(helper_x.get_rotation_degrees().x < 0):
#		y_compensation = -1
#	else:
#		y_compensation = 1
#	if(abs(helper_x.get_rotation_degrees().x) > 90):
#		y_weight = (180 - abs(helper_x.get_rotation_degrees().x) - abs(helper_z.get_rotation_degrees().z))/90
#		z_compensation = -1
#	else:
#		y_weight = (abs(helper_x.get_rotation_degrees().x))/90
#		z_compensation = 1
#	z_weight = 1- y_weight
#	rotate_y(Input.get_action_strength("move_right")*(-steer*y_weight*delta)* y_compensation)
#	rotate_y(Input.get_action_strength("move_left")*(steer*y_weight*delta)* y_compensation)
#	helper_z.rotate_z(Input.get_action_strength("move_right")*(steer*z_weight*delta)* z_compensation)
#	helper_z.rotate_z(Input.get_action_strength("move_left")*(-steer*z_weight*delta)* z_compensation)
#	helper_x.rotate_x(speed*delta)

func _process(delta) -> void:
	var steer_tmp = helper_x.transform.rotated(helper_x.transform.basis.y, Input.get_action_strength("move_right")*(-steer*delta) -Input.get_action_strength("move_left")*(-steer*delta))
	helper_x.set_transform(steer_tmp)
	var tmp = helper_x.transform.rotated(helper_x.transform.basis.x, speed * delta)
	helper_x.set_transform(tmp)
	time += delta
	if(time > speed_up_interval):
		time -= speed_up_interval
		speed += speed_increase
