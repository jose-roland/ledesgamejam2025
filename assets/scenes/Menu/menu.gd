class_name Menu_Class
extends Node2D

@onready var Button_Start = $VBoxContainer/HBoxContainer/VBoxContainer/Button as Button
@onready var Button_Settings = $VBoxContainer/HBoxContainer/VBoxContainer/Button2 as Button
@onready var Button_Exit = $VBoxContainer/HBoxContainer/VBoxContainer/Button3 as Button
@onready var Nivel1 = preload("res://assets/scenes/Nível 1.tscn") as PackedScene
@onready var Settings = preload("res://assets/scenes/Menu/Configurações.tscn") as PackedScene

func _ready():
	Button_Start.button_down.connect(Button_Start_Press)
	Button_Settings.button_down.connect(Button_Settings_Press)
	Button_Exit.button_down.connect(Button_Exit_Press)

func Button_Start_Press() -> void:
	get_tree().change_scene_to_packed(Nivel1)
	
func Button_Settings_Press() -> void:
	get_tree().change_scene_to_packed(Settings)
	
func Button_Exit_Press() -> void:
	get_tree().quit()
