extends Control

var countdown = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	update_label()



func _on_Timer_timeout():
	countdown -= 1 
	update_label()
	
func update_label():
	$Countdown.text = "Ready In " + str(countdown)
	if countdown <= 0:
		hide()
		$Down.stop()
		get_tree().paused = false
