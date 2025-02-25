extends Area2D
signal hit 
@onready var line_edit: LineEdit = $LineEdit
@onready var label: Label =$Label

@export var speed = 400 

var screen_size 
var isTyping = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	line_edit.text_changed.connect(_on_LineEdit_text_entered)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	# Text inputs 
	# For now, it's in the Player's code, but later it will probably be in its own code, 
	
	# We either start or stop writting, alternating with the current state
	if Input.is_action_just_pressed("write"): # "just" so that it counts the input once only
		if isTyping == false :
			line_edit.grab_focus()
			isTyping = true
		else : 
			isTyping = false
			line_edit.release_focus()
			line_edit.clear()

	
	# Movements 
	
	# Diagonal movements, recommended for the player
	if Input.is_action_pressed("move_right_up"):
		velocity.x+=1
		velocity.y-=1
	if Input.is_action_pressed("move_left_up"):
		velocity.x-=1
		velocity.y-=1
	if Input.is_action_pressed("move_left_down"):
		velocity.x-=1
		velocity.y+=1
	if Input.is_action_pressed("move_right_down"):
		velocity.x+=1
		velocity.y+=1
		
	# Horizontal and vertical movements, not recommended for the player
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("move_up"):
		velocity.y-=1
	if Input.is_action_pressed("move_down"):
		velocity.y+=1
		

			
	if velocity.length()>0 : 
		velocity = velocity.normalized()*speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Since diagonals are the main movements, this part will be modified 
	if velocity.x!=0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v=false
		$AnimatedSprite2D.flip_h=velocity.x<0 
	elif velocity.y !=0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y>0


func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_LineEdit_text_entered(text:String) -> void:
	label.text = "your name is "+ text 
	
