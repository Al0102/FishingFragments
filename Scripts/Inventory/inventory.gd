extends Resource
class_name Inventory

# Each item should be unique, but I'm too tired to figure this out rn
@export var items: Array[ItemStack]:
	set(value):
		for i in range(len(value)):
			items_dict[value[i].item] = i

var items_dict: Dictionary = {}

func _init(_items: Array[ItemStack] = []):
	items = _items

func set_item_stack(item_stack: ItemStack):
	# New if doesn't exist
	if !items_dict.has(item_stack.item):
		items.append(item_stack)
	else:
		items[items_dict[item_stack.item]] = item_stack
	filter()

func add_item(item: Item, amount: int = 1):
	if !items_dict.has(item):
		items.append(ItemStack.new(item, amount))
	else:
		items[items_dict[item]].quantity += amount
	filter()
	
func drop_item(item: Item, amount: int = 1) -> ItemStack:
	filter()
	if !items_dict.has(item) or amount == 0:
		return null
		
	amount = min(abs(amount), items[items_dict[item]].quantity)
	items[items_dict[item]].quantity -= amount
	return ItemStack.new(item, amount)

# removes empty stacks
func filter():
	items = items.filter(func(stack): return stack.quantity>0)
	
func has(item: Item):
	return items_dict.has(Item)
