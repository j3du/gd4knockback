extends CharacterBody3D


var box_react_knockback_dir = Vector3.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	box_react_knockback_dir = box_react_knockback_dir.move_toward(Vector3.ZERO,100 * delta)
	velocity = box_react_knockback_dir
	move_and_slide()
	
func _on_area_3d_area_entered(area):
	box_react_knockback_dir = area.knockback_vector * 25
