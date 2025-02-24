extends Area2D
signal hit 
@onready var line_edit: LineEdit = $LineEdit
@onready var label: Label =$Label

@export var speed = 400 

var screen_size 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	line_edit.text_submitted.connect(_on_LineEdit_text_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("movi_dekstren"):
		velocity.x+=1
	if Input.is_action_pressed("movi_maldekstren"):
		velocity.x-=1
	if Input.is_action_pressed("movi_supren"):
		velocity.y-=1
	if Input.is_action_pressed("movi_suben"):
		velocity.y+=1
	
	if Input.is_action_pressed("movi_dekstren_supren"):
		velocity.x+=1
		velocity.y+=1

	if Input.is_action_pressed("movi_maldekstren_supren"):
		velocity.x-=1
		velocity.y+=1

	if Input.is_action_pressed("movi_maldekstren_suben"):
		velocity.x-=1
		velocity.y-=1
	if Input.is_action_pressed("movi_dekstren_suben"):
		velocity.x+=1
		velocity.y-=1
	
	if velocity.length()>0 : 
		velocity = velocity.normalized()*speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x!=0:
		$AnimatedSprite2D.animation = "marsxi"
		$AnimatedSprite2D.flip_v=false
		$AnimatedSprite2D.flip_h=velocity.x<0 
	elif velocity.y !=0:
		$AnimatedSprite2D.animation = "supre"
		$AnimatedSprite2D.flip_v = velocity.y>0


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_LineEdit_text_entered(text:String) -> void:
	label.text = "your name is "+ text 
	
