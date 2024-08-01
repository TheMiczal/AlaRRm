extends Control

onready var lineEdit = $SetTime/LineEdit

var hours = 0
var minutes = 0
var seconds = 0

var time_left = 0

func _ready() -> void:
	$SetTime/LineEdit.grab_focus()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		process_command(lineEdit.text)
		lineEdit.clear()
	
	if $Timer.time_left > 0:
		$Counting/TimeLeft.text = "%02d:%02d:%02d" % [(float($Timer.time_left)/60)/60, (int($Timer.time_left)/60)%60, int($Timer.time_left)%60]

func process_command(tekst):
	if tekst != null:
		var split = tekst.split(" ")
		for i in range(0, split.size()):
			if "h" in split[i]:
				var hsplit = split[i].split("h")
				if hsplit[0] != "":
					hours = float(hsplit[0])
			
			if "min" in split[i]:
				if "min" in split[i]:
					var msplit = split[i].split("min")
					if msplit[0] != "":
						minutes = float(msplit[0])
			
			if "s" in split[i]:
				if "s" in split[i]:
					var ssplit = split[i].split("s")
					if ssplit[0] != "":
						seconds = float(ssplit[0])
	if seconds + minutes + hours > 0:
		$SetTime.visible = false
		$Counting.visible = true
		time_left = seconds + (minutes*60) + (hours*60*60)
		$Timer.start(time_left)
		$Timer2.start(1)


func _on_Cancel_pressed() -> void:
	$Timer.stop()
	$Counting.visible = false
	$SetTime.visible = true
	$SetTime/LineEdit.grab_focus()
	
	hours = 0
	minutes = 0
	seconds = 0
	time_left = 0


func _on_MTT_pressed() -> void:
	OS.window_minimized = true


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://Data/Scenes/Screen.tscn")
