extends Node2D





func _on_check_button_toggled(button_pressed):
	$Bars/Player.is_cpu = button_pressed
