extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay 	
@onready var label: Label = $CenterContainer/Panel/Label

# Função para atualizar o inventário
func update(slot: InvSlot) -> void:
	# Caso o slot esteja vazio
	if !slot.item:
		item_display.visible = false
		label.visible = false
	# Caso tenha item
	else:
		item_display.visible = true
		item_display.texture = slot.item.texture
		
		# A quantidade de item só é mostrada quando ela é maior que 1
		if slot.quantity > 1:
			label.visible = true
			
		label.text = str(slot.quantity)
