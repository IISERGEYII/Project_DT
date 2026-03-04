extends Node

class_name Logic

var info: Information
var main_text: RichTextLabel
var button_container: VBoxContainer
var times_label: Label
var final_label: Label
var list_notes_condition: ItemList
var button_notes: Button
var button_condition: Button
var button_return: Button

var overall_time = 200
var now_stage = ""
var now_actions_stages = []
var active_notes_texts = []
var active_conditions_texts = []

func _init(info, main_text, button_container, times_label, final_label,
 list_notes_condition, button_notes, button_condition, button_return):
	self.info = info
	self.main_text = main_text
	self.button_container = button_container
	self.times_label = times_label
	self.final_label = final_label
	self.list_notes_condition = list_notes_condition
	self.button_notes = button_notes
	self.button_condition = button_condition
	self.button_return = button_return

func set_stage(stage_id):
	times_label.text = str(overall_time)
	now_stage = stage_id
	now_actions_stages = info.stages[now_stage].actions_stage
	main_text.bbcode_text = info.stages[now_stage].main_text
	if button_container.get_child_count() != 0:
		clear_buttons()
	for action_stage in now_actions_stages:
		var flag = true
		if action_stage.conditions[0] == "":
			pass
		else:
			for condition in action_stage.conditions:
				if info.conditions[condition].active:
					continue
				else:
					flag = false
					break
		if flag:
			create_button(action_stage.button_text, action_stage.id_stage, action_stage.takes_time)

func create_button(button_text, id_stage, takes_time):
	var btn = Button.new()
	btn.text = button_text
	btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
	btn.pressed.connect(_on_button_pressed.bind(id_stage, takes_time))
	button_container.add_child(btn)

func _on_button_pressed(next_stage, takes_time):
	overall_time -= takes_time
	if overall_time <= 0:
		defeat()
	set_stage(next_stage)

func defeat():
	main_text.visible = false
	button_container.visible = false
	times_label.visible = false
	final_label.visible = true

func clear_buttons():
	for button in button_container.get_children():
		button.queue_free()
		
func loading_stages(fale_name):
	var file = FileAccess.open(fale_name, FileAccess.READ)
	var json_info = JSON.parse_string(file.get_as_text())
	file.close()
	for stage in json_info:
		info.stages[stage] = info.Stage.new(
			json_info[stage]["main_text"],
			loading_actions(json_info, stage)
		)

func loading_actions(json_info, stage) -> Array:
	var actions_stage = []
	for i in range(0, json_info[stage]["button_text"].size()):
		actions_stage.append(info.Action.new(
			json_info[stage]["button_text"][i],
			json_info[stage]["id_stage"][i],
			json_info[stage]["conditions"][i],
			json_info[stage]["takes_time"][i]))
	return actions_stage

func loading_notes(fale_name):
	var file = FileAccess.open(fale_name, FileAccess.READ)
	var json_info = JSON.parse_string(file.get_as_text())
	file.close()
	for note in json_info:
		info.notes[note] = info.Note.new(
			json_info[note]["text_note"],
			json_info[note]["id_conditions"]
		)

func loading_conditions(fale_name):
	var file = FileAccess.open(fale_name, FileAccess.READ)
	var json_info = JSON.parse_string(file.get_as_text())
	file.close()
	for condition in json_info:
		info.conditions[condition] = info.Condition.new(
			json_info[condition]["id_notes"],
			json_info[condition]["text_codition"]
		)

func _on_text_meta_cliked(click_note):
	if info.notes[click_note].active:
		pass
	else:
		info.notes[click_note].active = true
		active_notes_texts.append(info.notes[click_note].text_note)
		for condition in info.notes[click_note].id_conditions:
			checking_conditions(condition)

func checking_conditions(id_condiction):
	var flag = true
	for note in info.conditions[id_condiction].id_notes:
		if info.notes[note].active:
			continue
		else:
			flag = false
			break
	if flag:
		info.conditions[id_condiction].active = true
		active_conditions_texts.append(info.conditions[id_condiction].text)
		
func _on_button_notes_pressed():
	button_notes.visible = false
	button_condition.visible = false
	list_notes_condition.visible = true
	button_return.visible = true
	for note_text in active_notes_texts:
		list_notes_condition.add_item(note_text)

func _on_button_condition_pressed():
	button_notes.visible = false
	button_condition.visible = false
	list_notes_condition.visible = true
	button_return.visible = true
	for condition_text in active_conditions_texts:
		list_notes_condition.add_item(condition_text)

func _on_button_return_pressed():
	list_notes_condition.clear()
	list_notes_condition.visible = false
	button_return.visible = false
	button_notes.visible = true
	button_condition.visible = true
