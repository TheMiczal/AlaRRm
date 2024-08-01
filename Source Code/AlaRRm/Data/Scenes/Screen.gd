extends Control

func _ready() -> void:
	OS.window_minimized = false

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://Data/Scenes/Main.tscn")
