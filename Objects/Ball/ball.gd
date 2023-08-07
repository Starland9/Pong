extends CharacterBody2D
class_name Ball


signal out(player: int)

var speed := 8
var direction := Vector2.ZERO
@onready var angle = randf_range(0, 2 * PI)
@onready var _screen_size := DisplayServer.screen_get_size()
var _start_position
var _max_velocity := 5.0

func _ready():
	direction = angle_to_dir(angle)
	velocity = direction * 6
	_start_position = global_position
	
	
func angle_to_dir(angle_p):
	return Vector2(cos(angle_p), sin(angle_p))

func _physics_process(delta):
	var body = move_and_collide(velocity)
	if body:
		bounce(body)
	_verify_out()
		

func _verify_out():
	if global_position.x < -500:
		out.emit(-1)
	if global_position.x > _screen_size.x:
		out.emit(1)
	

func get_speed():
	return _max_velocity
	
func bounce(collision: KinematicCollision2D):
	var linear_velocity = velocity
	var normal = collision.get_normal()
	var reflexion = linear_velocity.reflect(normal)
	velocity = linear_velocity - 2 * reflexion 
	_max_velocity += 0.1
	clamp_velocity()
	
	
func clamp_velocity():
	velocity.x = clamp(velocity.x, -_max_velocity, _max_velocity)
	velocity.y = clamp(velocity.y, -_max_velocity, _max_velocity)
	

func _on_out(player):
	_reset_ball(player)
	
func _reset_ball(direction: int = 0):
	_max_velocity = 5
	global_position = _start_position - (Vector2(direction * 300 , 1))
	
func _input(event):
	if event is InputEventScreenTouch:
		if event.double_tap:
			_reset_ball()
