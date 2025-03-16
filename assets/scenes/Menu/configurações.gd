class_name Config
extends Node2D

@onready var Button_Back = $Button as Button
@onready var Button_Text = $Button2 as Button

func _ready():
	Button_Back.button_down.connect(Button_Back_Press)

func Button_Back_Press() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/Menu/Menu.tscn")
