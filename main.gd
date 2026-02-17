extends Node2D

@onready var main_text = %Main_text
@onready var button_container = %Button_Container
var information = Information.new()

func _ready() -> void:
	information.loading_information("res://stages.json")
	var logic = Logic.new(information, main_text, button_container)
	logic.set_stage("stage0")
