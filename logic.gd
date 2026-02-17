extends Node

class_name Logic

var info: Information
var main_text: RichTextLabel
var button_container: VBoxContainer

var now_stage = ""
var now_actions_stage = []

func _init(info, main_text, button_container):
	self.info = info
	self.main_text = main_text
	self.button_container = button_container

func set_stage(stage_id: String):
	now_stage = stage_id
	now_actions_stage = info.stages[now_stage].actions_stage
	main_text.text = info.stages[now_stage].main_text
	if button_container.get_child_count() != 0:
		clear_buttons()
	for i in range(0, now_actions_stage.size()):
		if now_actions_stage[i].condition == "":
			create_button(now_actions_stage[i].button_text, now_actions_stage[i].id_stage)

func create_button(button_text, id_stage):
	var btn = Button.new()
	btn.text = button_text
	btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
	btn.pressed.connect(_on_button_pressed.bind(id_stage))
	button_container.add_child(btn)

func _on_button_pressed(next_stage: String):
	set_stage(next_stage)

func clear_buttons():
	for button in button_container.get_children():
		button.queue_free()
