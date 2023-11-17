extends Node2D


	
func _on_visible_on_screen_notifier_2d_screen_entered():
	await get_tree().create_timer(.15).timeout
	get_tree().quit()
