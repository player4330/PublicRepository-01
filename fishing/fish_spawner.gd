extends Node2D

# 建議：在編輯器右側 Inspector 中手動拖入 fish.tscn 檔案到這個欄位
@export var fish_scene: PackedScene 

func _on_timer_timeout():
	spawn_fish()

func spawn_fish():
	# 安全檢查：確保已經指定了魚的場景
	if not fish_scene:
		print("錯誤：尚未在 Inspector 中指定 fish_scene！")
		return
		
	# 1. 實例化魚
	var new_fish = fish_scene.instantiate()
	
	
	# 2. 獲取螢幕（視窗）的實際尺寸
	var screen_size = get_viewport_rect().size
	
	# 3. 計算隨機位置
	# randf_range(最小值, 最大值)
	var random_x = randf_range(50, screen_size.x - 50)
	var random_y = randf_range(0, screen_size.y)
	
	# 4. 設定位置並加入場景
	new_fish.position = Vector2(random_x, random_y)
	add_child(new_fish)
	
	# 調試訊息（可選）：幫助你確認魚生成在哪裡
	# print("魚生成在：", new_fish.position)
