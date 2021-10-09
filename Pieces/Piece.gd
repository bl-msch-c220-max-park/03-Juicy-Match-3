extends Node2D

export (String) var color
export var roatate_speed = 1.0 
var is_matched
var is_counted
var selected = false
var target_position = Vector2(0,0)
var default_modulate = Color(1,1,1,1)
var highlight = Color(1,0.8,0,1)


var sound_1 = null
var sound_2 = null
var sound_3 = null

var fall_speed = 0.75

var dying = false

var Effects = null
var wiggle = 0.0
export var wiggle_amount = 3

export var transparent_time = 1.0
export var scale_time = 1.5
export var rot_time = 1.5

func _ready():
	default_modulate = modulate
	

func _physics_process(_delta):
	if dying and not $Tween.is_active():
		queue_free()
	if selected:
		$Selected.emitting = true
		$Select.show()
		z_index = 10 
	else:
		$Selected.emitting = false 
		$Select.hide()
		z_index = 1 

	
func move_piece(change):
	target_position = position + change
	position = target_position
	if sound_2 == null:
		sound_2 = get_node_or_null("/root/Game/Sweet")
	if sound_2 != null:
		sound_2.play()
func die():	
	dying = true 
	if sound_3 == null:
		sound_3 = get_node_or_null("/root/Game/Yeah")
	if sound_3 != null:
		sound_3.play()
	var target_color = $Sprite.modulate.darkened(0.45)
	target_color.s = 1
	target_color.a = 0
	var fall_duration = randf()+ fall_speed + 1 
	var rotate_amount = (randi() % 1440) - 720
	$Dead.show()
	
	var target_pos = position
	target_pos.y = 1600
	$Tween.interpolate_property(self, "position", position, target_pos, fall_duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property($Sprite, "modulate", $Sprite.modulate, target_color, fall_duration-0.45, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	$Tween.interpolate_property(self, "rotation_degrees",rotation_degrees, rotate_amount, fall_duration-0.45, Tween.TRANS_QUINT, Tween.EASE_IN)
	
	

