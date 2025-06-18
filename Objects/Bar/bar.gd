extends CharacterBody2D
class_name Bar

var speed := 1000

@export var is_cpu := false
@export var ball : Node2D
var pos_x


func _ready():
	pos_x = global_position.x




func _physics_process(_delta):
	velocity.x = 0
	if is_cpu:
		_follow_ball()
	else:
		_move_by_inputs()
	velocity.x = 0
	global_position.x = pos_x


func _move_by_inputs():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed

	move_and_slide()



func _follow_ball():
	if ball == null:
		return

	var distance_y := ball.global_position.y - global_position.y
	var distance_x := ball.global_position.x - global_position.x
	var ball_speed = ball.get_speed()
	var vision_distance = 150 * ball_speed / 5
	if abs(distance_x) < vision_distance:
		velocity.y += distance_y * ball_speed / 5

	move_and_slide()


func _input(event):
	if event is InputEventScreenDrag and not is_cpu:
		position.y = event.position.y
