extends ParallaxBackground

export var speed:int = 100
var offset_scroll = 0


func _process(delta):
	offset_scroll += speed * delta
	
	set_scroll_offset(Vector2(-offset_scroll,0))
