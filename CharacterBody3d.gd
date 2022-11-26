extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var can_move = true
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	get_input()
	move_and_slide()

func get_input():
	if !can_move:
		return
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$Player_area.knockback_vector = direction #Using player input for box_react knockback direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

#BOX_BLUE STATIC KNOCKBACK
func knock_back():
	velocity *= -1
	velocity.y = 3
	can_move = false
	await get_tree().create_timer(0.8). timeout
	can_move = true
	
#BOX_RED KNOCKBACK
func _on_player_area_body_entered(body):
	if body.is_in_group("box_red"):
		velocity = (global_transform.origin - body.global_transform.origin).normalized()
		velocity.y = 3
		can_move = false
		await get_tree().create_timer(0.8). timeout
		can_move = true
		
