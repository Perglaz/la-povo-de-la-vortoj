extends Node

@onready var line_edit: LineEdit = $Player/LineEdit
@onready var player : Area2D = $Player

var isTyping = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit.text_changed.connect(_on_LineEdit_text_entered) # each time a letter is changed we call _on_LineEdit_text_entered
	# I will use another one like on text_submit later in order to check sentences and not words only

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# Text inputs 
	# For now, it's in the main code, but later it mightbe in its own script, 
	
	# We either start or stop writting, alternating with the current state
	if Input.is_action_just_pressed("write"): # "just" so that it counts the input once only
		if isTyping == false :
			line_edit.grab_focus()
			isTyping = true
		else : 
			isTyping = false
			line_edit.release_focus()
			line_edit.clear()



func _on_LineEdit_text_entered(text:String) -> void:
	if text =="akvo" : # water
		create_block(text, player.position)
		line_edit.clear()

func create_block(text:String, position:Vector2) -> void: 
	# used to create a block, for now it's a block of water
	if text =="akvo" : # water
		var akvo = ColorRect.new()
		akvo.color= Color(0.212, 0.271, 1)
		akvo.size = Vector2(50,30)
		akvo.position = set_created_object_position(player.position, player.direction)

		add_child(akvo)

func set_created_object_position(position:Vector2,direction:float) -> Vector2:
	# it will be used to set the position of a newly created object
	# for now , it may lack a center to place correctly the object
	# the diagonal directions might need to be normalized with .normalized()
	
	# there is a problem here with multiple directional keys pressed at the same time (direction only saves one input, not 2)
	var new_position = position
	var length = 100 # temporary 
	match direction: 
		0: 
			new_position+=Vector2(length,0) # doesn't seem to work 
		PI/4:
			new_position+=Vector2(length,-length)
		PI/2:
			new_position+=Vector2(0,-length)
		3*PI/4:
			new_position+=Vector2(-length,-length)
		PI:
			new_position+=Vector2(-length,0)
		-PI/4:
			new_position+=Vector2(length,length)
		-PI/2:
			new_position+=Vector2(0,length)
		-3*PI/4:
			new_position+=Vector2(-length,length)
	return new_position
			
	
