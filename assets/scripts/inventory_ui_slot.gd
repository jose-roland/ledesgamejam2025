extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay 	
@onready var label: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot) -> void:
	if !slot.item:
		item_display.visible = false
		label.visible = false
	else:
		item_display.visible = true
		item_display.texture = slot.item.texture
		if slot.quantity > 1:
			label.visible = true
		label.text = str(slot.quantity)
