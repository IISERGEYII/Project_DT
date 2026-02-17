extends Node

class_name Information

class Action:
	var button_text: String
	var id_stage: String
	var condition: String
	
	func _init(button_text, id_stage, condition):
		self.button_text = button_text
		self.id_stage = id_stage
		self.condition = condition

class Stage:
	var main_text: String
	var actions_stage: Array
	
	func _init(main_text, actions_stage):
		self.main_text = main_text
		self.actions_stage = actions_stage

var stages = {}

func loading_information(fale_info):
	var file = FileAccess.open(fale_info, FileAccess.READ)
	var json_info = JSON.parse_string(file.get_as_text())
	file.close()
	for stage in json_info:
		self.stages[stage] = Stage.new(
			json_info[stage]["main_text"],
			loading_action(json_info, stage)
		)

func loading_action(json_info, stage) -> Array:
	var actions_stage = []
	for i in range(0, json_info[stage]["button_text"].size()):
		actions_stage.append(Action.new(
			json_info[stage]["button_text"][i],
			json_info[stage]["id_stage"][i],
			json_info[stage]["condition"][i]))
		print(actions_stage)
	return actions_stage
