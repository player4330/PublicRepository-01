extends Sprite2D # 假設你的魚竿是一個 Sprite

var hook_scene = preload("res://Hook")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		launch_hook()

func launch_hook():
	var hook = hook_scene.instantiate()
	# 將滑鼠目前的全球座標傳給魚鉤
	hook.target_position = get_global_mouse_position()
	# 設定魚鉤初始位置（例如魚竿頂端）
	hook.global_position = global_position 
	
	# 將魚鉤加入到場景樹中（建議加入到 root 或 Level 節點，以免隨玩家移動）
	get_tree().current_scene.add_child(hook)
