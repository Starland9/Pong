extends CanvasLayer

@onready var left_score_label := $Scores/Sprite2D/ScoreLeft
@onready var right_score_label := $Scores/Sprite2D2/ScoreRight

var left_score := 0
var right_score := 0

func _update_score(player: int):
	if player == 1:
		left_score += 1
		left_score_label.text = str(left_score)

	if player == -1:
		right_score += 1
		right_score_label.text = str(right_score)


func _on_ball_out(player):
	_update_score(player)
