extends Area2D

# 設定移動速度範圍
@export var min_speed: float = 80.0
@export var max_speed: float = 200.0

var speed: float = 0.0
var direction: int = 1 # 1 代表向右, -1 代表向左

func _ready():
	# 1. 隨機決定速度
	speed = randf_range(min_speed, max_speed)
	
	# 2. 隨機決定方向：50% 機率向左，50% 機率向右
	if randf() > 0.5:
		direction = 1  # 向右
		scale.x = abs(scale.x) # 確保圖片朝右（假設原始圖片朝右）
	else:
		direction = -1 # 向左
		scale.x = -abs(scale.x) # 將圖片水平翻轉朝
	set_process(true)

func _process(delta):
	# 3. 只在 X 軸上移動
	position.x += speed * direction * delta
	
	# 4. 超出左右邊界後自動銷毀
	check_off_screen()

func check_off_screen():
	var screen_size = get_viewport_rect().size
	# 如果向右游超出右邊，或向左游超出左邊
	if (direction == 1 and position.x > screen_size.x + 100) or \
	   (direction == -1 and position.x < -100):
		queue_free()
