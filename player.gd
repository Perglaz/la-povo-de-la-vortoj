extends Area2D
signal hit 
@export var speed = 400 
var direction:Vector2 = Vector2.ZERO

var screen_size 
var isTyping # linked to _on_line_edit_editing_toggled to know if the player is typing
var delay = 0.1 # in seconds, used to update the direction frequently

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity  = Vector2.ZERO 
	delay -= delta 
	# Movements 
	if !isTyping: 	# The player can't move while typing
		# Diagonal movements, recommended for the player
		if Input.is_action_pressed("move_right_up"):
			velocity += Vector2(1,-1)
		if Input.is_action_pressed("move_left_up"):
			velocity += Vector2(-1,-1)
		if Input.is_action_pressed("move_left_down"):
			velocity += Vector2(-1,1)
		if Input.is_action_pressed("move_right_down"):
			velocity += Vector2(1,1)
			
		# Horizontal and vertical movements, not recommended for the player
		if Input.is_action_pressed("move_right"):
			velocity += Vector2(1,0)
		if Input.is_action_pressed("move_left"):
			velocity += Vector2(-1,0)
		if Input.is_action_pressed("move_up"):
			velocity += Vector2(0,-1)
		if Input.is_action_pressed("move_down"):
			velocity += Vector2(0,1)
	
	# we update the direction every 0.1 second
	if  delay<0:
		if velocity !=Vector2.ZERO :
			direction = velocity.normalized()
		delay=0.1

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
