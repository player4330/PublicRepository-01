extends CharacterBody2D

@export var speed: float = 600.0          
@export var return_speed: float = 400.0   
@onready var origin_node = get_parent()   

enum State { IDLE, LAUNCHING, RETRACTING } 
var current_state = State.IDLE
var target_position: Vector2 = Vector2.ZERO

func _ready():
	global_position = origin_node.global_position
	
	# 自動連接訊號（假設你的 Area2D 子節點名稱就叫 Area2D）
	# 你也可以手動在編輯器介面點擊「Node」分頁來連接 _on_area_2d_area_entered
	if has_node("Area2D"):
		$Area2D.area_entered.connect(_on_hook_area_entered)

func _input(event):
	if event.is_action_pressed("ui_accept") and current_state == State.IDLE:
		target_position = get_global_mouse_position()
		current_state = State.LAUNCHING

func _physics_process(delta):
	match current_state:
		State.IDLE:
			global_position = origin_node.global_position
			velocity = Vector2.ZERO
			
		State.LAUNCHING:
			var dir = (target_position - global_position).normalized()
			velocity = dir * speed
			
			if global_position.distance_to(target_position) < 10.0:
				current_state = State.RETRACTING
			
			move_and_slide()
			
		State.RETRACTING:
			var origin_pos = origin_node.global_position
			var dir = (origin_pos - global_position).normalized()
			velocity = dir * return_speed
			
			if global_position.distance_to(origin_pos) < 15.0: # 稍微加大判定範圍確保順利回航
				current_state = State.IDLE
				global_position = origin_pos 
				
			move_and_slide()

# --- 碰撞處理函數 ---
func _on_hook_area_entered(area):
	# 只有在「發射中」碰到魚才算數
	if current_state == State.LAUNCHING and area.is_in_group("fish"):
		print("命中！抓到魚了")
		
		# 1. 讓魚消失
		area.queue_free() 
		
		# 2. 立即轉換狀態為收回
		current_state = State.RETRACTING
