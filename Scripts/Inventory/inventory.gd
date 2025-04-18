extends Resource
class_name Inventory

# Each item should be unique, but I'm too tired to figure this out rn
@export var items: Array[ItemStack]

var items_dict: Dictionary

func _init(_items: Array[ItemStack] = []):
	items = _items
	update()

func set_item_stack(item_stack: ItemStack):
	update()
	# New if doesn't exist
	if !items_dict.has(item_stack.item.id):
		items.append(item_stack)
	else:
		items[items_dict[item_stack.item].id].quantity = item_stack.quantity
	update()

func add_item(item: Item, amount: int = 1):
	filter()
	update()
	if !items_dict.has(item.id):
		items.append(ItemStack.new(item, amount))
	else:
		items[items_dict[item.id]].quantity += amount
	update()
	
func drop_item(item: Item, amount: int = 1) -> ItemStack:
	update()
	if !items_dict.has(item.id) or amount <= 0:
		return null
		
	amount = min(abs(amount), items[items_dict[item.id]].quantity)
	items[items_dict[item.id]].quantity -= amount
	filter()
	update()
	return ItemStack.new(item, amount)

func clear():
	items.clear()
	items_dict.clear()
	update()

func clear_and_get() -> Array[ItemStack]:
	var duped_items = items.duplicate()
	clear()
	return duped_items

func update():
	if len(items) > 0:
		for i in range(len(items)):
			print(items[i].quantity)
			items_dict[items[i].item.id] = i
	else:
		items_dict.clear()
	print("vslue: ",items)

# removes empty stacks
func filter():
	var i: int = 0
	while i < len(items):
		if items[i].quantity == 0:
			items.remove_at(i)
			continue
		i += 1
	
func has(item: Item):
	return items_dict.has(item.id)
