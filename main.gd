extends Node2D

@onready var main_text = %Main_text
@onready var button_container = %Button_Container
var information = Information.new()

func _ready() -> void:
	var logic = Logic.new(information, main_text, button_container)
	logic.loading_stages("res://stages.json")
	logic.loading_notes("res://notes.json")
	logic.loading_conditions("res://conditions.json")
	main_text.meta_clicked.connect(logic._on_text_meta_cliked)
	logic.set_stage("stage0")
