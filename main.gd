extends Node

# TODO add another scene that we can controle from main, with colorRect and player inside 


@onready var line_edit: LineEdit = $Player/LineEdit
@onready var player : Area2D = $Player
@onready var book : Node2D = $Book

var isTyping = false # used to prevent movements while typing 
var isSearching = false # used to prevent using powers while looking for words

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit.text_submitted.connect(_on_LineEdit_text_submitted) # each time a text is submitted (with enter) we call _on_LineEdit_text_entered
	# i might check when the text is changed for enemies
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# Text inputs 
	# For now, it's in the main code, but later it might be in its own script, 
	
	# We either start or stop writting, alternating with the current state
	if Input.is_action_just_pressed("start_writting") and isTyping==false: # "just" so that it counts the input once only
			isTyping = true
			line_edit.visible=!line_edit.visible # we show the input box only when writting
			line_edit.grab_focus()

	if Input.is_action_just_pressed("finish_writting") and isTyping==true: 
			isTyping = false
			line_edit.visible=!line_edit.visible # we show the input box only when writting
			line_edit.release_focus()
			line_edit.clear()
			
	# add escaoe to exit the book ; or maybe write "fermi" at the beginning and autorhize escape key later ? 



func _on_LineEdit_text_submitted(text:String) -> void:
	
	# TODO faire un fichier à part, en faisant des class pour gérer tout ça
	
	#if text =="krei ...." : #  text to analyse , to create a block
	if text == "akvo" or text== "vojo" :
		create_block(text, player.position)
		line_edit.clear()
		
	# display of the book
	# open the book
	elif text == "libro":
		# while reading the book, the player can't move, and can't use his powers 
		# a bar should display what the player is typing 
		book.visible = true
		isSearching = true
	# close the book
	elif text == "fermi":
		book.visible = false
		isSearching = false 
		
func create_block(text:String, _position:Vector2) -> void: 
	# used to create a block, for now it's a block of water
	if text =="akvo" : # water
		# creation of water
		var akvo= createWater()
		add_child(akvo)
	if text == "vojo" : # path # ne plu funkcias iel 
		var vojo = createPath()
		add_child(vojo)
			
func createPath() -> Area2D : # i'll add more customization later
	var vojo= Area2D.new()
	var size = Vector2(50,30)
	
	vojo.position = set_created_object_position(player.position, player.direction)
	# the rectangle 
	var colorRect = createColorRect(Color(0.686, 0.478, 0.29),size )
	vojo.add_child(colorRect)
	# the collision
	var shape = RectangleShape2D.new()
	shape.size = size
	var collision = createCollisionShape(RectangleShape2D.new())
	vojo.add_child(collision)
	
	return vojo

func createWater() -> Area2D : # i'll add more customization later
	var akvo= Area2D.new()
	
	akvo.position = set_created_object_position(player.position, player.direction)
	
	# the sprite 
	var sprite = createSprite2D("res://.godot/imported/akvo.PNG-597057749c8a86437cf100d54f45fc22.ctex", Vector2(0.14, 0.14))
	akvo.add_child(sprite)
	
	# the collision
	var shape = CircleShape2D.new()
	shape.radius = 18
	var collision = createCollisionShape(CircleShape2D.new())
	akvo.add_child(collision)
	
	return akvo

func createCollisionShape(shape:Shape2D) -> CollisionShape2D :
	var collision = CollisionShape2D.new()
	collision.shape = shape	
	return collision

func createSprite2D(load_path:String, scale:Vector2) -> Sprite2D :
	var sprite = Sprite2D.new()
	sprite.texture = load(load_path)
	sprite.scale = scale
	return sprite

func createColorRect(color:Color, size:Vector2) -> ColorRect : 
	var colorRect = ColorRect.new()
	colorRect.color = color
	colorRect.size = size
	return colorRect




func set_created_object_position(position:Vector2,direction:Vector2) -> Vector2:
	# it will be used to set the position of a newly created object
	# for now , it may lack a center to place correctly the object
	# the diagonal directions might need to be normalized with .normalized()
	
	var length = 100 # temporary 
	var new_position = position+length*direction

	return new_position
