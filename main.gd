extends Node2D

@onready var main_text = %Main_text
@onready var button_container = %Button_Container
@onready var times_label = %Times_Label
@onready var final_label = %Final_Label
@onready var list_notes_condition = %ListNotesCondition
@onready var button_note = %ButtonNote
@onready var button_condition = %ButtonCondition
@onready var button_return = %ButtonReturn

var information = Information.new()

func _ready() -> void:
	var logic = Logic.new(information, main_text, button_container, times_label, final_label,
	 list_notes_condition, button_note, button_condition, button_return)
	logic.loading_stages("res://stages.json")
	logic.loading_notes("res://notes.json")
	logic.loading_conditions("res://conditions.json")
	main_text.meta_clicked.connect(logic._on_text_meta_cliked)
	button_note.pressed.connect(logic._on_button_notes_pressed.bind())
	button_condition.pressed.connect(logic._on_button_condition_pressed.bind())
	button_return.pressed.connect(logic._on_button_return_pressed.bind())
	logic.set_stage("stage0")
