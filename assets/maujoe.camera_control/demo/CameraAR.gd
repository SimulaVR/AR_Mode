extends Node2D

var cameraTexture: CameraTexture
# onready var arShader = preload("res://CanvasARShader.tres")

func _ready():
	var camFeed = CameraServer.get_feed(0)
	camFeed.set_active(true)
	cameraTexture = CameraTexture.new()
	cameraTexture.set_camera_feed_id(1)
	# # var shaderMaterial = ShaderMaterial.new()
	# var shaderResource = load("res://CanvasARShader.tres")
	# set_material(shaderResource)
	# self.material.shader = arShader
	# self.material.set_shader_param("u_angle", 3.491)

func _process(delta):
	update()

func _draw():
	var cameraTextureSizeX = cameraTexture.get_size().x
	var cameraTextureSizeY = cameraTexture.get_size().y
	if cameraTextureSizeX == 0 or cameraTextureSizeY == 0:
		return
	var viewportWidth = get_viewport_rect().size.x
	var viewportHeight = get_viewport_rect().size.y
	var ratioX = viewportWidth/cameraTextureSizeX
	var ratioY = viewportHeight/cameraTextureSizeY
	var ratio = ratioX
	var offsetX = 0
	var offsetY = 0

	if ratioX > ratioY:
		ratio = ratioX
		offsetY = (viewportHeight -cameraTextureSizeY*ratioX)/2
	elif ratioY > ratioX:
		ratio = ratioY
		offsetX = (viewportWidth - cameraTextureSizeX*ratioY)/2

	draw_set_transform(Vector2(offsetX, offsetY), 0, Vector2(ratio, ratio))
	draw_texture(cameraTexture, Vector2(0,0))
