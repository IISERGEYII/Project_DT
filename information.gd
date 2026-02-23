extends Node

class_name Information

class Condition:
	var active = false
	var id_note: Array

class Action:
	var button_text: String
	var id_stage: String
	var conditions: Array
	
	func _init(button_text, id_stage, conditions):
		self.button_text = button_text
		self.id_stage = id_stage
		self.conditions = conditions

class Note:
	var text_note: String
	var active = false
	var id_conditions: Array
	
	func _init(text_note, id_condictions) -> void:
		self.text_note = text_note
		self.id_conditions = id_condictions

	func set_active():
		self.active = true

class Stage:
	var main_text: String
	var actions_stage: Array
	
	func _init(main_text, actions_stage):
		self.main_text = main_text
		self.actions_stage = actions_stage

var stages = {}
var notes = {}
