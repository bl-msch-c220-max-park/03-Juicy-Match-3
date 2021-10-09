extends Control

func _ready():
	var _score_changed = Global.connect("score_changed",self,"_on_score_changed")
	var _time_changed = Global.connect("time_change", self,"_on_time_change")
	_on_score_changed()
	_on_time_change()
	$How.show()
	get_tree().paused = true 
	
func _on_score_changed():
	$Score.text = "Score: " + str(Global.score)

func _on_time_change():
	$Timer.text = "Timer: " + str(Global.time)

func _on_Time_timeout():
	Global.time_change(self)
