extends Area2D
signal hit 
@export var speed = 400 
var direction:float  = 0# we don't need it in this file, we will need it to know the direction of the player to create objects

var screen_size 
var isTyping

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity  = Vector2.ZERO 
	# We either start or stop writting, alternating with the current state
	#if Input.is_action_just_pressed("start_writting") or Input.is_action_just_pressed("finish_writting"): # "just" so that it counts the input once only
		#isTyping=!isTyping
		#$LineEdit.visible=!$LineEdit.visible # we show the input box only when writting
	#
	# Movements 

	if !isTyping: 	# The player can't move while typing
		# Diagonal movements, recommended for the player
		if Input.is_action_pressed("move_right_up"):
			velocity.x+=1
			velocity.y-=1
			direction = PI/4
		if Input.is_action_pressed("move_left_up"):
			velocity.x-=1
			velocity.y-=1
			direction = 3*PI/4
		if Input.is_action_pressed("move_left_down"):
			velocity.x-=1
			velocity.y+=1
			direction =-3*PI/4 
		if Input.is_action_pressed("move_right_down"):
			velocity.x+=1
			velocity.y+=1
			direction = -PI/4
			
		# Horizontal and vertical movements, not recommended for the player
		if Input.is_action_pressed("move_right"):
			velocity.x+=1
			direction = 0
		if Input.is_action_pressed("move_left"):
			velocity.x-=1
			direction = PI
		if Input.is_action_pressed("move_up"):
			velocity.y-=1
			direction = PI/2
		if Input.is_action_pressed("move_down"):
			velocity.y+=1
			direction = -PI/2
			
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


# To know if the player is writting or not 
func _on_line_edit_editing_toggled(toggled_on: bool) -> void:
	isTyping=toggled_on 
