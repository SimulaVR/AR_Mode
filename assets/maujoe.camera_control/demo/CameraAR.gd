extends Node2D

var cameraTexture: CameraTexture

func _ready():
	var camFeed = CameraServer.get_feed(0)
	camFeed.set_active(true)
	cameraTexture = CameraTexture.new()
	cameraTexture.set_camera_feed_id(1)

func _process(delta):
	update()

func _draw():
	draw_texture(cameraTexture, Vector2(0,0))

