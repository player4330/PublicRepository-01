extends CharacterBody2D

var speed = 500  # 飛往滑鼠的速度
var target_position = Vector2.ZERO

func _ready():
	# 讓魚鉤在生成時就看向滑鼠位置
	look_at(target_position)

func _physics_process(delta):
	# 計算往目標移動的向量
	var direction = (target_position - global_position).normalized()
	
	# 移動魚鉤
	velocity = direction * speed
	move_and_slide()

	# 如果非常接近目標點，就停止或消失（避免在原地抖動）
	if global_position.distance_to(target_position) < 10:
		set_physics_process(false) 
		# 你可以在這裡加入回傳魚線的邏輯
